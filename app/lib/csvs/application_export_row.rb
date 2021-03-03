class Csvs::ApplicationExportRow < Grape::Entity
  class << self
    def column(*args, **options)
      expose *args, **options.except(:no, :header)
    end

    def generate(model, context)
      represent(model, **context).as_json.values.map(&:to_s)
    end
  end
end
