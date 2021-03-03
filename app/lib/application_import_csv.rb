class ApplicationImportCsv
  include ActiveModel::Model
  include ActiveModel::Attributes

  class_attribute :types, default: {}, instance_predicate: false, instance_accessor: false
  class_attribute :model_class, instance_predicate: false
  class_attribute :virtual_attribute_names, default: [], instance_predicate: false, instance_accessor: false

  class << self
    def column(name, type = ActiveModel::Type::Value.new, **options)
      attribute name, default: options[:default], type: :string
      if type.is_a?(Symbol)
        type = ActiveModel::Type.lookup(type, **options.except(:default))
      end
      self.types = types.merge(name.to_s => type)
    end

    def parse(row)
      attributes = attribute_names.map.with_index do |attribute_name, index|
        [attribute_name, row[index]]
      end.to_h

      new(attributes)
    end

    def model(class_name)
      self.model_class = class_name
    end

    def virtual(name)
      attr_accessor name
      self.virtual_attribute_names = [*self.virtual_attribute_names, name]
    end
  end

  def attributes
    return @_attributes if @_attributes

    columns = self.class.attribute_names.map do |attribute_name|
      [attribute_name, self.class.types[attribute_name].serialize(public_send(attribute_name))]
    end
    virtual_attributes = self.class.virtual_attribute_names.map do |attribute_name|
      [attribute_name, public_send(attribute_name)]
    end
    @_attributes = columns.concat(virtual_attributes).to_h
  end
end