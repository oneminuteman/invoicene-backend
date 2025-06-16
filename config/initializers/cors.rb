# config/initializers/cors.rb

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # Use specific origins for your Android app
    # For Android Emulator: 10.0.2.2 refers to the host machine's localhost
    # For local development: http://localhost:3000 (if your app isn't on the same port)
    # For actual device: Your computer's local IP address (e.g., 'http://192.168.1.X:3000')
    origins 'http://10.0.2.2:3000', 'http://localhost:3000'
    # Add your actual device's IP if you're testing on a physical device on your local network
    # origins 'http://10.0.2.2:3000', 'http://localhost:3000', 'http://192.168.1.100:3000' # Example for a physical device

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      credentials: true # This is now secure because origins are restricted
  end
end
