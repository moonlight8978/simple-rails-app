class Forms::ChangePassword < ApplicationForm
  attribute :current_password, :string, exclude: true
  attribute :password, :string

  validates :current_password, presence: true
  validates :password, presence: true
  validates :password, confirmation: true, if: -> { password.present? && password_confirmation.present? }
  validates :password_confirmation, presence: true
  validate :current_password_must_match

  def save_model
    model.update(attributes)
    true
  end

  private

  def current_password_must_match
    return if current_password.blank?

    errors.add(:current_password, :mismatch) unless model.authenticate(current_password)
  end
end
