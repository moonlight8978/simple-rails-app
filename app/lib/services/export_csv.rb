class Services::ExportCsv < ApplicationService
  def perform(collection, io, iterator, **context)
    collection.find_each do |record|
      rows = Array(iterator.call(record, context))
      rows.each { |row| io << row }
    end

    yield iterator if block_given?
  end
end
