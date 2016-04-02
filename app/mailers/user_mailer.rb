class UserMailer < ApplicationMailer
  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password Reset"
  end

  def add_client(user, client, email, user_id)
    @client = client
    @user = user
    @user_id = user_id
    mail to: email, subject: "Sign Up for ZenJobs"
  end
end
