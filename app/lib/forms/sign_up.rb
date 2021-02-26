class Forms::SignUp < ApplicationForm
  attribute :username, :string
  attribute :password, :string
  attribute :email_notification_enabled, :boolean
  attribute :email, :string

  attr_accessor :user

  validates :username, presence: true
  validates :password, presence: true
  validates :password, confirmation: true, if: -> { password.present? && password_confirmation.present?}
  validates :password_confirmation, presence: true
  validates :email, presence: true, if: -> { email_notification_enabled }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  validate :username_must_be_unique

  def save_model
    self.user = User.create(attributes)
    true
  end

  private

  def username_must_be_unique
    return unless precondition_fulfilled?

    errors.add(:username, :taken) if User.exists?(username: username)
  end

  def precondition_fulfilled?
    username.present? && password.present? && password_confirmation.present?
  end
end
