class Csvs::Import::Iterators::Basic
  attr_accessor :row_definition

  def initialize(row_definition)
    self.row_definition = row_definition
  end

  def call(row)
    attributes = row_definition.parse(row).attributes
    model = row_definition.model_class.new(attributes)
    model.save

    row_definition.errors.merge(model.errors) if model.errors.any?
  end
end
