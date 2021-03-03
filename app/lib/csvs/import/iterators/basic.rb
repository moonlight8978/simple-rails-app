class Csvs::Import::Iterators::Basic
  attr_accessor :csv_definition

  def initialize(csv_definition)
    self.csv_definition = csv_definition
  end

  def call(row)
    attributes = csv_definition.parse(row).attributes
    model = csv_definition.model_class.new(attributes)
    model.save

    csv_definition.errors.merge(model.errors) if model.errors.any?
  end
end
