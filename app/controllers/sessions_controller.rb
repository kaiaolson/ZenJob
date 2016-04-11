class SessionsController < ApplicationController
  def new
    respond_to do |format|
      format.html { render :new } #for my controller, i wanted it to be JS only
      format.js
    end
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      log_in(user)
      if session[:return_to]
        redirect_to session.delete(:return_to), notice: "You are successfully logged in!"
      else
        redirect_to info_requests_path, notice: "You are successfully logged in!"
      end
    else
      flash[:alert] = "Wrong credentials!"
      redirect_to new_session_path
    end
  end

  def destroy
    session[:user_id], session[:return_to] = nil
    flash[:notice] = "You are logged out!"
    redirect_to root_path
  end
end
