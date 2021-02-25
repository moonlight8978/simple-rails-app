require_relative "boot"

require "rails/all"

Dir[File.join(__dir__, 'preconfig', '*.rb')].each { |file| require file }

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    config.load_defaults 6.1

    config.time_zone = ActiveSupport::TimeZone::MAPPING["Hanoi"]
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
