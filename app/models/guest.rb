class Guest
  class Avatar < String
    def attached?
      true
    end
  end

  attr_accessor :username

  def initialize(username: 'Guest')
    @username = username
  end

  def guest?
    true
  end

  def persisted?
    false
  end

  def avatar
    @avtar ||= Avatar.new("https://via.placeholder.com/50x50")
  end
end
