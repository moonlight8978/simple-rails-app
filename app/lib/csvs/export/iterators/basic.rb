class Csvs::Export::Iterators::Basic
  attr_accessor :row_definition

  def initialize(row_definition)
    self.row_definition = row_definition
  end

  def call(record, context)
    require 'csv'

    CSV.generate_line(row_definition.generate(record, context))
  end
end
