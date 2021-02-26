class User < ApplicationRecord
  has_secure_password

  has_one_attached :avatar

  class << self
    def authenticate?(username:, password:)
      user = User.find_or_initialize_by(username: username)
    end
  end

  def guest?
    false
  end
end
