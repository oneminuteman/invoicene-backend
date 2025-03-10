# Configure Puma threads
# Set the number of threads for the server
threads_count = ENV.fetch("RAILS_MAX_THREADS", 3).to_i
threads threads_count, threads_count

# Set the port for HTTP
port ENV.fetch("PORT", 3000)

# Allow Puma to be restarted by `bin/rails restart` command
plugin :tmp_restart

# Specify the PID file, if requested
pidfile ENV["PIDFILE"] if ENV["PIDFILE"]

# Set SSL if SSL files are present
if File.exist?("config/ssl/localhost.key") && File.exist?("config/ssl/localhost.crt")
  # Use SSL if certificates are found
  ssl_bind '0.0.0.0', '3001', {
    key: "config/ssl/localhost.key",
    cert: "config/ssl/localhost.crt"
  }
  puts "Puma is running in HTTPS mode on port 3001"
else
  # If SSL files are not found, run in HTTP mode
  bind "tcp://0.0.0.0:3000"
  puts "SSL files not found, running in HTTP mode on port 3000"
end
