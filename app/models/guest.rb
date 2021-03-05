class Guest
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

  def avatar_variants
    @avatar_variants ||= Avatar.new
  end
end
