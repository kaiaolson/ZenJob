class InfoRequestsController < ApplicationController
  before_action :authenticate_user, only: [:show]
  before_action :find_info_request, only: [:show, :edit, :update]

  def new
    @info_request = InfoRequest.new
    respond_to do |format|
      format.js {:new}
    end
  end

  def create
    @info_request = InfoRequest.new info_request_params
    @info_request.user = current_user
    respond_to do |format|
      if @info_request.save
        client_id = Relationship.find(@info_request.relationship_id).relation_id
        InfoRequestsMailer.new_request(current_user.id, client_id, @info_request).deliver_later
        format.html { redirect_to info_requests_path, notice: "Request created!" }
        format.js   { render :create_success }
      else
        format.html { render :new, alert: "Request not created!" }
        format.js   { render :create_failure }
      end
    end
  end

  def index
    respond_to do |format|
      if params[:filter] == "false"
        @info_requests = current_user.info_requests.where(completed: "false").page params[:page]
        format.html
        format.js   { render :filter_requests }
      elsif params[:filter] == "true"
        @info_requests = current_user.info_requests.where(completed: "true").page params[:page]
        format.html
        format.js   { render :filter_requests }
      else
        @info_requests = current_user.info_requests.page params[:page]
        format.html
        format.js   { render :filter_requests }
      end
    end
  end

  def show
    render js: :create_success
  end

  def edit
    render :js
  end

  def update
    respond_to do |format|
      if @info_request.update info_request_params
        format.html { redirect_to @info_request, notice: "Request updated!"}
        format.js   { render :update_success }
      else
        format.html { render :edit, alert: "Unable to update request. Please check errors."}
        format.js   { render :update_failure }
      end
    end
  end

  def destroy
    @info_request = current_user.info_requests.find params[:id]
    @info_request.destroy
    redirect_to info_requests_path, notice: "Request deleted!"
  end

  private

  def info_request_params
    params.require(:info_request).permit(:title, :description, :requirements, :category_id, :completed, :relationship_id)
  end

  def find_info_request
    @info_request = InfoRequest.find params[:id]
  end
end
