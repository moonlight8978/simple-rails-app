class Forms::SignIn < ApplicationForm
  attribute :username, :string
  attribute :password, :string

  validates :username, presence: true
  validates :password, presence: true
  validate :username_must_exist
  validate :password_must_match

  def user
    @user ||= User.find_by_username(username)
  end

  def username_must_exist
    return if username.blank?

    errors.add(:username, :mismatch) unless user
  end

  def password_must_match
    return if password.blank?

    errors.add(:password, :mismatch) unless user&.authenticate(password)
  end
end
