class Feature
  class << self
    def use_ssm?
      ENV["USE_SSM"].present?
    end

    def use_redis?
      ENV["USE_REDIS"].present?
    end
  end
end
