class Api::V1::UsersController < Api::BaseController
  skip_before_action :verify_authenticity_token

  def index
    @users = User.all
    render json: {users: @users}
  end

  def sign_in
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      render json: {user: @user}
    else
      head :unauthorized
    end
  end

  def sign_out
    session[:user_id], session[:return_to] = nil
    flash[:notice] = "You are logged out!"
    redirect_to root_path
  end

end
