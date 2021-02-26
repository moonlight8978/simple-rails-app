class ApplicationForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  class_attribute :attributes, default: [], instance_reader: false, instance_writer: false, instance_accessor: false, instance_predicate: false

  class << self
    def attribute(*args, **options)
      super(*args, **options.except(:exclude))

      attributes.push(args[0]) unless options[:exclude]
    end

    def untyped_attribute(name, **options)
      attr_accessor name
      attributes.push(name) unless options[:exclude]

      default_value = options[:default]
      public_send(:"#{name}=", default_value) if default_value
    end
  end

  untyped_attribute :model, exclude: true

  def invalid?
    !valid?
  end

  def save
    return false unless valid?

    save_model
  end

  def save_model
    raise NoMethodError
  end

  def attributes
    self.class.attributes.map do |attr|
      [attr, self.public_send(attr)]
    end.to_h
  end
end
