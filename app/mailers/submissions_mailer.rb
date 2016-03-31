class SubmissionsMailer < ApplicationMailer
  def new_submission(consultant, client, submission)
    @consultant = User.find consultant
    @client = User.find client
    @submission = submission
    @info_request = InfoRequest.find submission.info_request_id
    mail to: @consultant.email, subject: "New Submission"
  end
end
