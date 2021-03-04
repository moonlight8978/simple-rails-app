require 'csv'

class Csvs::Export::Iterators::Basic
  attr_accessor :row_definition

  class << self
    alias_method :with, :new
  end

  def initialize(row_definition)
    self.row_definition = row_definition
  end

  def headers
    CSV.generate_line(row_definition.headers)
  end

  def call(record, context)
    CSV.generate_line(row_definition.generate(record, context))
  end
end
