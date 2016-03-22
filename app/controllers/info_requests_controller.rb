class InfoRequestsController < ApplicationController
  before_action :authenticate_user
  before_action :find_info_request, only: [:show, :edit, :update, :destroy]

  def new
    @info_request = InfoRequest.new
  end

  def create
    @info_request = InfoRequest.new info_request_params
    @info_request.user = current_user
    if @info_request.save
      redirect_to info_requests_path, notice: "Request created!"
    else
      render :new, alert: "Request not created!"
    end
  end

  def index
    if current_user.consultant?
      if params[:filter] == "false"
        @info_requests = current_user.info_requests.where(completed: "false").order(:id)
      elsif params[:filter] == "true"
        @info_requests = current_user.info_requests.where(completed: "true").order(:id)
      else
        @info_requests = current_user.info_requests.order(:id)
      end
    else
      if params[:filter] == "false"
        @info_requests = User.info_requests(@current_user).where(completed: "false")
      elsif params[:filter] == "true"
        @info_requests = User.info_requests(@current_user).where(completed: "true")
      else
        @info_requests = User.info_requests(@current_user).order(:id)
      end
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def info_request_params
    params.require(:info_request).permit(:title, :description, :requirements, :category_id, :completed, :relationship_id)
  end

  def find_info_request
    @info_request = InfoRequest.find params[:id]
  end
end
