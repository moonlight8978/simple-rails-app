class User < ApplicationRecord
  has_secure_password

  has_one_attached :avatar

  has_many :notes, inverse_of: :user, dependent: :destroy

  def guest?
    false
  end
end
