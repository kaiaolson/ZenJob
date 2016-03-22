class UsersController < ApplicationController
  before_action :authenticate_user, only: [:show, :edit, :update, :destroy]
  before_action :find_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    user = User.new user_params
    if user.save
      log_in(user)
      flash[:notice] = "User created!"
      user.role == "consultant" ? (redirect_to info_requests_path) : (redirect_to submissions_path)
    else
      flash[:alert] = "User not created, see errors!"
      redirect_to new_user_path
    end
  end

  def show
  end

  def index
  end

  def edit
  end

  def update
    if @user.update user_params
      redirect_to user_path(@user), notice: "Profile updated successfully."
    else
      flash[:alert] = "Profile not updated."
      @changing_password ? (render :change_password) : (render :edit)
    end
  end

  def destroy
    @user = User.find params[:id]
    if can? :destroy, @user
      @user.destroy
      session[:user_id] = nil
      flash[:notice] = "User deleted!"
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  def change_password
    @user = User.find params[:user_id]
  end

  private

  def find_user
    @user = User.find current_user.id
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :role, :password)
  end

  def check_password
    authentic_password = @user.authenticate(params[:user]["current_password"])
    different_password = params[:user]["current_password"] != params[:user]["password"]
    @changing_password = params[:user]["password"]
    @changing_password ? (authentic_password && different_password) : authentic_password
  end
end
