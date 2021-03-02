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
      system_test_mode? || Rails.env.development? && ENV["USE_FAKE_MAILER"].present?
    end

    def system_test_mode?
      ENV["SYSTEM_TEST"].present?
    end
  end
end
