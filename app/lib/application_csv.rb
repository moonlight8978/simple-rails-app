class ApplicationCsv
  class << self
    class_attribute :attributes

    def column(name, **options, no:)
      attribute name, **options
      self.attributes = [*attributes, name]
    end
  end
end
