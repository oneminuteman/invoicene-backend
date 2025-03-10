class ApplicationController < ActionController::Base
  include ActionController::MimeResponds

  before_action :set_default_format

  private

  # Ensure all API requests under "/locations/" respond with JSON by default
  def set_default_format
    request.format = :json if request.path.start_with?("/locations/")
  end
end
