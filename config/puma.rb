# Puma thread pool configuration
threads_count = ENV.fetch("RAILS_MAX_THREADS", 3).to_i
threads threads_count, threads_count

# PID file (optional)
pidfile ENV["PIDFILE"] if ENV["PIDFILE"]

# Allow Puma to be restarted by `bin/rails restart`
plugin :tmp_restart

# Bind HTTP port (always)
bind "tcp://0.0.0.0:3000"

# Conditionally bind HTTPS port if SSL files are present
if File.exist?("config/ssl/localhost.key") && File.exist?("config/ssl/localhost.crt")
  ssl_bind '0.0.0.0', '3001', {
    key: "config/ssl/localhost.key",
    cert: "config/ssl/localhost.crt",
    verify_mode: 'none'
  }
  puts "Puma is running in HTTPS mode on port 3001"
else
  puts "SSL files not found. Running HTTP only on port 3000"
end

