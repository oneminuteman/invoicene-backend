# config/application.rb

require_relative "boot"

require "rails/all" # This ensures all standard Rails components are loaded.

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Myinvoiceapp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0 # Using Rails 8.0 defaults as per your latest context.

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API-only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # This line should be uncommented if you are building an API-only application.
    config.api_only = true

    # --- Manual re-addition of Session Middleware for API-only app ---
    # When config.api_only = true, sessions are disabled by default.
    # To enable sessions (which your authentication system relies on),
    # you must explicitly add the session middleware back.
    config.session_store :cookie_store, key: '_myinvoiceapp_session' # Choose a unique and secure key
    config.middleware.use ActionDispatch::Cookies # Required for cookie_store
    config.middleware.use config.session_store, config.session_options # Adds the session management to middleware

    # --- CORS Configuration (Keep this in config/initializers/cors.rb) ---
    # The CORS configuration block should typically reside in
    # `config/initializers/cors.rb` as it's cleaner and the conventional
    # place for Rack::Cors setup.
    # You should have already configured this in `config/initializers/cors.rb`
    # as per previous instructions. Do NOT duplicate it here.
    #
    # For reference, if you were to put it here (which is not recommended):
    # config.middleware.insert_before 0, Rack::Cors do
    #   allow do
    #     origins 'http://10.0.2.2:3000', 'http://localhost:3000' # Your allowed origins
    #     resource '*',
    #       headers: :any,
    #       methods: [:get, :post, :put, :patch, :delete, :options, :head],
    #       credentials: true # Crucial for session cookies to be sent
    #   end
    # end
  end
end