class ClientsController < ApplicationController
  def new
  end

  def create
    client = User.find_by_email(params[:email])
    if client
      @relationship = current_user.relationships.build(relation_id: client.id)
      if @relationship.save
        flash[:notice] = "Added client."
        redirect_to root_url
      else
        flash[:error] = "Unable to add client."
        redirect_to root_url
      end
    else
      # send mailer asking to sign up
      print "not found!"
      redirect_to root_url
    end
  end

  def index
    @clients = current_user.clients
  end

  def destroy

  end
end
