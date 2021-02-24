class Forms::SignUp < ApplicationForm
  attribute :username, :string
  attribute :password, :string

  attr_accessor :user

  validates :username, presence: true
  validates :password, presence: true
  validates :password, confirmation: true, if: -> { password.present? && password_confirmation.present?}
  validates :password_confirmation, presence: true
  validate :username_must_be_unique

  def save
    return false unless valid?

    self.user = User.create(username: username, password: password)
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
