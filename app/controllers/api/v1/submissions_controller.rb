class Api::V1::SubmissionsController < Api::BaseController
  skip_before_action :verify_authenticity_token

  def index
    render nothing: true
  end

  def create
    # params = params.require(:document).permit(:type_id, :user_id, :related_to_type, :related_to_id)
    render json: params
  end
end
