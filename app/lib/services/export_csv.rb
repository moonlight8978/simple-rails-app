class Services::ExportCsv < ApplicationService
  attr_accessor :context, :io

  def initialize(io = nil, **context)
    self.io = io
    self.context = context
  end

  def perform(collection, iterator, headers: true, batch_size: 1000)
    io << iterator.headers if headers

    iterate = proc do |record|
      rows = Array(iterator.call(record, context))
      rows.each { |row| io << row }
    end

    if batch_size
      collection.find_each(batch_size: batch_size, &iterate)
    else
      collection.each(&iterate)
    end

    yield iterator if block_given?
  end
end
