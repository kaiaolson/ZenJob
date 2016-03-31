class InfoRequestsMailer < ApplicationMailer
  def new_request(consultant_id, client_id, info_request)
    @consultant = User.find(consultant_id)
    @client = User.find(client_id)
    @info_request = InfoRequest.find info_request
    mail to: @client.email, subject: "New Request"
  end
end
