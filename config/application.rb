require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    config.load_defaults 6.1

    config.time_zone = ActiveSupport::TimeZone::MAPPING["Hanoi"]
    # config.eager_load_paths << Rails.root.join("extras")

    Dir[File.join(__dir__, 'preconfig', '*.rb')].each { |file| require file }

    config.active_storage.service = Feature.use_s3? ? :amazon : :local

    config.hosts << "99fb7a6932f7.ngrok.io"
  end
end
