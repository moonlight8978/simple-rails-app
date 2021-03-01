class Services::SendRegistrationMail
  def perform(user)
    UserMailer.with(user: user).registration_completion.deliver_now if user.email_notification_enabled
  end
end
