class Forms::ChangeNotificationSettings < ApplicationForm
  field :email, type: :string
  field :email_notification_enabled, type: :boolean

  enumerize :email_notification_enabled, in: { disabled: 0, enabled: 1 }, default: :disabled

  validates :email, presence: true, if: :email_notification_enabled
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
end
