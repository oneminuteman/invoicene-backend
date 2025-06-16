
class ApplicationController < ActionController::API
  # --- Middleware Support ---
  include ActionController::Cookies
  include ActionController::MimeResponds
  include ActionController::RequestForgeryProtection

  # --- CSRF Protection ---
  # Protect with :exception for web requests, but allow mobile JSON API requests if token is present
  protect_from_forgery with: :exception, unless: -> { request.format.json? }

  # --- Default Request Format ---
  before_action :set_default_format

  # --- Error Handling ---
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActionController::InvalidAuthenticityToken, with: :handle_invalid_authenticity_token

  # --- Authentication Helpers ---
  helper_method :current_user, :authorize

  # --- CSRF Token Endpoint ---
  def csrf_token
    render json: { csrf_token: form_authenticity_token }
  end

  private

  # --- Set Default Request Format to JSON ---
  def set_default_format
    request.format = :json if request.path.start_with?(
      "/locations/", "/signup", "/login", "/me", "/users"
    )
  end

  # --- Current Logged-in User ---
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # --- Authorization Gate ---
  def authorize
    render json: { errors: ["Not authorized"] }, status: :unauthorized unless current_user
  end

  # --- Render 422 for Validation Errors ---
  def render_unprocessable_entity_response(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end

  # --- Render 404 for Record Not Found ---
  def render_not_found_response(exception)
    render json: { error: exception.message }, status: :not_found
  end

  # --- Handle Invalid CSRF Token Error Gracefully ---
  def handle_invalid_authenticity_token
    render json: { error: "Invalid CSRF token" }, status: :unauthorized
  end
end
