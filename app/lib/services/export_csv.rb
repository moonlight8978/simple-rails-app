class Services::ExportCsv < ApplicationService
  attr_accessor :context, :io

  def initialize(io = nil, **context)
    self.io = io
    self.context = context
  end

  def perform(collection, iterator, headers: true)
    io << iterator.headers if headers

    collection.each do |record|
      rows = Array(iterator.call(record, context))
      rows.each { |row| io << row }
    end

    yield iterator if block_given?
  end
end
