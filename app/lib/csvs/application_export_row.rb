require 'csv'

class Csvs::ApplicationExportRow < Grape::Entity
  format_with :boolean do |value|
    value ? 1 : 0
  end

  format_with :date do |date|
    date.strftime("%Y-%m-%d") if date.present?
  end

  class << self
    def column(*args, **options)
      expose *args, **options.except(:no, :header, :documentation), documentation: { desc: options[:header] }
    end

    def generate_line(model, context)
      CSV.generate_line(represent(model, **context).as_json.values.map(&:to_s))
    end

    def generate_headers_line
      CSV.generate_line(documentation.map { |_attr, doc| doc[:desc] })
    end
  end
end
