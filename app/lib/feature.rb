class Feature
  class << self
    def use_ssm?
      ENV["USE_SSM"].present?
    end

    def use_redis?
      ENV["USE_REDIS"].present?
    end

    def use_s3?
      ENV["USE_S3"].present?
    end

    def use_dev_fake_mailer?
      Rails.env.development? && ENV["USE_FAKE_MAILER"].present?
    end
  end
end
