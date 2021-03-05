class Avatar
  class DefaultAttachment < String
    def attached?
      true
    end
  end

  BIG = DefaultAttachment.new("https://via.placeholder.com/150x150")
  SMALL = DefaultAttachment.new("https://via.placeholder.com/50x50")

  attr_accessor :attachment

  def initialize(attachment = nil)
    self.attachment = attachment
  end

  def original
    attached? ? attachment : BIG
  end

  def thumbnail
    attached? ? attachment : SMALL
  end

  def attached?
    attachment&.attached?
  end
end
