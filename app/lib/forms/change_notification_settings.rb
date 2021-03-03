class Forms::ChangeNotificationSettings < ApplicationForm
  field :email, type: :string
  field :email_notification_enabled, type: :boolean

  validates :email, presence: true, if: -> { email_notification_enabled }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
end
