require 'csv'

class Csvs::Export::Iterators::Basic
  attr_accessor :row_definition, :collection, :context

  def initialize(collection, row_definition, **context)
    self.collection = collection
    self.row_definition = row_definition
    self.context = context
  end

  def each
    collection.each do |record|
      yield CSV.generate_line(row_definition.generate(record, context))
    end
  end
end
