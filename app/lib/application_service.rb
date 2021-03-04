class ApplicationService
  class << self
    def perform(*args, **options)
      new.perform(*args, **options)
    end
  end
end
