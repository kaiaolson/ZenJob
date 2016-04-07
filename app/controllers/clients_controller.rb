class ClientsController < ApplicationController
  def new
    respond_to do |format|
      format.js { :new }
    end
  end

  def create
    client = User.find_by_email(params[:email])
    @client_name = "#{params[:first_name]} #{params[:last_name]}"
    respond_to do |format|
      if client
        @relationship = current_user.relationships.build(relation_id: client.id)
        if @relationship.save
          @clients = current_user.clients
          format.html { redirect_to clients_path, notice: "Added #{@client_name} to your client list!" }
          format.js   { render :create_success }
        else
          format.html { flash[:error] = "Unable to add #{@client_name}, please see errors."
                        redirect_to new_client_path }
          format.js   { render :create_failure }
        end
      else
        # send mailer asking to sign up
        UserMailer.add_client(current_user.full_name, @client_name, params[:email], current_user.id).deliver_later
        format.html { redirect_to root_url, notice: "#{@client_name} has been sent an email inviting them to sign up for ZenJobs!" }
        format.js   { :client_emailed }
      end
    end
  end

  def index
    @filter = params[:filter]
    respond_to do |format|
      if @filter == "active"
        @clients = current_user.active_clients
        format.html
        format.js { render :filter_clients }
      elsif @filter == "archive"
        @clients = current_user.archived_clients
        format.html
        format.js { render :filter_clients }
      else
        @clients = current_user.clients
        format.html
        format.js { render :filter_clients }
      end
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
