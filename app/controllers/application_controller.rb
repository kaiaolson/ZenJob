class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def log_in(user)
    session[:user_id] = user.id
  end

  def user_signed_in?
    session[:user_id].present?
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if user_signed_in?
  end

  def authenticate_user
    session[:return_to] ||= request.url
    redirect_to new_session_path, notice: "Please sign in." unless user_signed_in?
  end

  def notifications?
    current_user.pending_requests_count > 0 || current_user.pending_submissions_count > 0
  end

  helper_method :user_signed_in?
  helper_method :current_user
  helper_method :notifications?
end
