class UserMailer < ApplicationMailer
  default from: ENV["MAIL_FROM_ADDRESS"]

  layout 'mailer'

  def registration_completion
    @user = params[:user]
    mail(to: @user.email, subject: 'SRA - Registration Completed!')
  end
end
