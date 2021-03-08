class Csvs::Import::RowProcessors::Basic
  attr_accessor :row_definition, :context

  def initialize(row_definition, **context)
    self.row_definition = row_definition
    self.context = context
  end

  def call(row)
    attributes = row_definition.parse(row, **context).attributes
    model = row_definition.model_class.new(attributes)
    model.save

    row_definition.errors.merge(model.errors) if model.errors.any?
  end
end
