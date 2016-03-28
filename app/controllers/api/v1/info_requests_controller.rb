class Api::V1::InfoRequestsController < Api::BaseController
  def index
    user = User.find params[:user_id]
    @info_requests = user.info_requests
    render json: @info_requests
  end

  def show
    @info_request = InfoRequest.find params[:id]
    render json: @info_request
  end
end
