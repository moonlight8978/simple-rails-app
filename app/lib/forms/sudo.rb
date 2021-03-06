class Forms::Sudo < ApplicationForm
  field :password, type: :string
  field :key, type: :string
  field :return_to, type: :string

  validates :key, presence: true
  validates :return_to, presence: true
  validates :password, presence: true
  validate :password_must_match

  def session_key
    key.presence && "_password_#{key}"
  end

  private

  def password_must_match
    errors.add(:password, :mismatch) unless password.present? && model.authenticate(password)
  end
end
