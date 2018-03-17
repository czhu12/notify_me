require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Notifyme
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    config.autoload_paths << "#{Rails.root}/lib"
    # Messenger Bot config
    config.paths.add File.join("app", "bot"), glob: File.join("**","*.rb")
    config.autoload_paths += Dir[Rails.root.join("app", "bot", "*")]

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
