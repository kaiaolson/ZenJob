class ClientsController < ApplicationController
  def new
  end

  def create
    client = User.find_by_email(params[:email])
    client_name = "#{params[:first_name]} #{params[:last_name]}"
    if client
      @relationship = current_user.relationships.build(relation_id: client.id)
      if @relationship.save
        redirect_to info_requests_path, notice: "Added #{client_name} to your client list!"
      else
        flash[:error] = "Unable to add #{client_name}, please see errors."
        redirect_to info_requests_path
      end
    else
      # send mailer asking to sign up
      UserMailer.add_client(current_user.full_name, client_name, params[:email], current_user.id).deliver_later
      redirect_to root_url, notice: "#{client_name} has been sent an email inviting them to sign up for ZenJobs!"
    end
  end

  def index
    if params[:filter] == "active"
      @clients = current_user.active_clients.page params[:page]
    elsif params[:filter] == "archive"
      @clients = current_user.archived_clients.page params[:page]
    else
      @clients = current_user.clients.page params[:page]
    end
  end

  def update
    r = current_user.relationships.find_by_relation_id params[:client_id]
    r.archive!
    redirect_to clients_path, notice: "Client archived!"
  end

  def destroy

  end
end
