class Services::SendRegistrationMail
  def perform(user)
    return unless user.mail_notification_enabled

    UserMailer.with(user: user).registration_completion.deliver_now
  end
end
