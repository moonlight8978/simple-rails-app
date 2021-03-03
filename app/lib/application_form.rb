class ApplicationForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  class_attribute :attribute_names, default: [], instance_predicate: false, instance_accessor: false

  def self.field(name, type = nil, **options)
    attr_accessor name
    if type.is_a?(Symbol)
      type = ActiveModel::Type.lookup(type, **options.except(:default))
    end
    self.attribute_names = [*attribute_names, name] unless options[:exclude]
    self.attribute_types = attribute_types.merge(name.to_s => type)
  end

  field :model, exclude: true

  def invalid?
    !valid?
  end

  def save
    return false unless valid?

    save_model
  end

  def save_model
    model.update(attributes)
    true
  end

  def attributes
    self.class.attribute_names.map do |attr|
      type = self.class.attribute_types[attr.to_s]
      value = self.public_send(attr)
      [attr, type ? type.serialize(value) : value]
    end.to_h
  end
end
