require 'csv'

class Services::ImportCsv < ApplicationService
  Row = Struct.new("Row", :no, :data, keyword_init: true)

  def perform(csv_file, iterator = Csvs::Import::Iterators::Basic.new)
    index = 1
    ActiveRecord::Base.transaction do
      ::CSV.foreach(csv_file, encoding: "utf-8", headers: true) do |row|
        iterator.call(Row.new(no: index, data: row))
        index += 1
      end

      raise ArgumentError, iterator.errors.join("\n") if iterator.errors.any?

      yield iterator if block_given?
    end
  end
end
