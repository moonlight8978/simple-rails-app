class Services::ExportCsv < ApplicationService
  attr_accessor :context, :io

  def initialize(io)
    self.io = io
  end

  def perform(iterator, headers: nil, after: proc {})
    io << headers if headers

    iterator.each do |csv_lines|
      Array(csv_lines).each { |line| io << line }
    end

    after.call(iterator)
  end
end
