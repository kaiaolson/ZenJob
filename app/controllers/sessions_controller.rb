class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      log_in(user)
      redirect_to info_requests_path, notice: "You are successfully logged in!"
    else
      flash[:alert] = "Wrong credentials!"
      redirect_to new_session_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You are logged out!"
    redirect_to root_path
  end
end
