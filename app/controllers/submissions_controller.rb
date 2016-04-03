class SubmissionsController < ApplicationController
  before_action :find_submission, only: [:show, :edit, :update, :destroy]
  protect_from_forgery with: :null_session

  def new
    @submission = Submission.new(info_request_id: params[:info_request_id])
  end

  def create
    @submission = Submission.new submission_params
    @submission.info_request_id = params[:info_request_id]
    @submission.user = current_user
    if @submission.save
      if params[:submission][:completed] == "1"
        i = InfoRequest.find params[:info_request_id]
        i.completed = true
        i.save
      end
      consultant_id = Relationship.find(@submission.relationship_id).user_id
      SubmissionsMailer.new_submission(consultant_id, current_user.id, @submission).deliver_later
      redirect_to info_request_submission_path(@submission.info_request_id, @submission), notice: "Submission created!"
    else
      render :new, alert: "Submission not created!"
    end
  end

  # def create
  #   p params
  #   @submission = Submission.new(images: params[:file])
  #   if @submission.save
  #     head :ok
  #   else
  #     render json: { errors: @submission.errors.full_messages }
  #   end
  # end

  def show

  end

  def index
    respond_to do |format|
      if params[:filter] == "false"
        @submissions = current_user.submissions.where(completed: "false").page params[:page]
        format.html
        format.js { render :filter_submissions }
      elsif params[:filter] == "true"
        @submissions = current_user.submissions.where(completed: "true").page params[:page]
        format.html
        format.js { render :filter_submissions }
      else
        @submissions = current_user.submissions.page params[:page]
        format.html
        format.js { render :filter_submissions }
      end
    end
  end

  def edit
  end

  def update
    if @submission.update submission_params
      if params[:submission][:completed] == "1"
        i = InfoRequest.find params[:info_request_id]
        i.completed = true
        i.save
      end
      redirect_to info_request_submission_path(@submission.info_request_id, @submission), notice: "Submission updated!"
    else
      flash[:alert] = "Submission not updated!"
      render :edit
    end
  end

  def destroy
    @submission.destroy
    flash[:notice] = "Your submission was deleted!"
    redirect_to submissions_path
  end

  private

  def submission_params
    params.require(:submission).permit(:notes, :completed, :user_id, :info_request_id, :text_content, :username, :email, :password, {files: []}, :relationship_id)
  end

  def find_submission
    @submission = Submission.find params[:id]
  end
end
