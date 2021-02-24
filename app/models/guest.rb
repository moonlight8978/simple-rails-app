class Guest
  attr_accessor :username

  def initialize(username: 'Guest')
    @username = username
  end

  def guest?
    true
  end
end
