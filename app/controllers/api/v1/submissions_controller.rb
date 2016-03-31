class Api::V1::SubmissionsController < Api::BaseController
  skip_before_action :verify_authenticity_token

  def index
    render nothing: true
  end

  def create
    byebug
    head :ok
  end
end
