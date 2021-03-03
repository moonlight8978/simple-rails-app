class Forms::SignUp < ApplicationForm
  field :username, :string
  field :password, :string
  field :email_notification_enabled, :boolean
  field :email, :string

  validates :username, presence: true
  validates :password, presence: true
  validates :password, confirmation: true, if: -> { password.present? && password_confirmation.present?}
  validates :password_confirmation, presence: true
  validates :email, presence: true, if: :email_notification_enabled
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  validate :username_must_be_unique

  def save_model
    self.model = User.create!(attributes)
    true
  end

  private

  def username_must_be_unique
    return if username.blank?

    errors.add(:username, :taken) if User.exists?(username: username)
  end
end
