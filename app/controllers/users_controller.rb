class UsersController < ApplicationController
  before_action :authenticate_user, only: [:show, :edit, :update, :destroy]
  before_action :find_user, only: [:show, :edit, :update]

  def new
    @user = User.new
    if params[:consultant_id]
      @consultant = User.find params[:consultant_id]
      @consultant_id = @consultant.id
    else
      @consultant_id = nil
    end
    respond_to do |format|
      format.html { render :new } #for my controller, i wanted it to be JS only
      format.js   { :new }
    end
  end

  def create
    user = User.new user_params
    if user.save
      Relationship.create(user_id: params[:user][:consultant].to_i, relation_id: user.id) if params[:user][:consultant]
      log_in(user)
      redirect_to info_requests_path, notice: "Profile created successfully!"
    else
      flash[:alert] = "User not created, see errors!"
      redirect_to new_user_path
    end
  end

  def show
    respond_to do |format|
      format.js {:show}
    end
  end

  def index
  end

  def edit
    respond_to do |format|
      format.js {:edit}
    end
  end

  def update
    respond_to do |format|
      if @user.update user_params
        format.html { redirect_to user_path(@user), notice: "Profile updated successfully."}
        format.js   { render :update_success }
      else
        format.html { flash[:alert] = "Profile not updated."
                      @changing_password ? (render :change_password) : (render :edit) }
        format.js   { render :update_failure }
      end
    end
  end

  def destroy
    @user = User.find params[:id]
    if can? :destroy, @user
      @user.destroy
      session[:user_id] = nil
      redirect_to root_path, notice: "User deleted!"
    else
      redirect_to root_path, notice: "User not deleted!"
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
