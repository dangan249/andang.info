require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AndangInfo
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
    config.autoload_paths << Rails.root.join('lib/tasks')
    config.linkedin_email = ENV['LINKEDIN_EMAIL']
    config.linkedin_password = ENV['LINKEDIN_PASSWORD']
    config.linkedin_access_token = ENV['LINKEDIN_ACCESS_TOKEN']
  end
end

LinkedIn.configure do |config|
  config.client_id = ENV['LINKEDIN_CLIENT_ID']
  config.client_secret = ENV['LINKEDIN_CLIENT_SECRET']
  # This must exactly match the redirect URI you set on your application's
  # settings page. If your redirect_uri is dynamic, pass it into
  # `auth_code_url` instead.
  config.redirect_uri  = ENV['LINKEDIN_REDIRECT_URL']
end

require 'capybara/poltergeist'

# driver_options = { js_errors: false,
#                    logger: NilLogger.new,
#                    phantomjs_logger: STDOUT,
#                    phantomjs_options: ['--debug=true'],
#                    debug: false  }

Capybara.configure do |capybara|
  capybara.run_server = true
  # capybara.register_driver :poltergeist do |app|
  #   Capybara::Poltergeist::Driver.new(app, driver_options)
  # end
  capybara.current_driver = :poltergeist
end