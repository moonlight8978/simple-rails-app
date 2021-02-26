class ApplicationForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  class_attribute :attributes, default: [], instance_accessor: false

  def self.attribute(*args, **options)
    super(*args, **options.except(:exclude))

    self.attributes = [*attributes, args[0]] unless options[:exclude]
  end

  def self.untyped_attribute(name, **options)
    attr_accessor name
    self.attributes = [*attributes, name] unless options[:exclude]

    default_value = options[:default]
    public_send(:"#{name}=", default_value) if default_value
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
