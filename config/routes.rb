# config/routes.rb
Rails.application.routes.draw do
  # --- Root Route ---
  # Defines the root path route ("/").
  # This is the default page loaded when you access the root URL of your application.
  root "locations#index"

  # --- Favicon Route ---
  # Route for favicon.ico: Redirects favicon requests to a static asset.
  # This prevents errors for browsers requesting the favicon.
  get '/favicon.ico', to: redirect('/assets/favicon.ico')

  # --- User Authentication Routes ---
  # User registration
  post '/signup', to: 'users#create'
  # Current logged-in user details
  get '/me', to: 'users#show'
  # List all users (protected by authorize, but skipped for index in UsersController)
  get '/users', to: 'users#index'

  # Session management (login/logout)
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # --- CSRF Token Route ---
  # This endpoint provides the CSRF token to clients.
  # Clients should fetch this token and include it in the 'X-CSRF-Token' header
  # for all non-GET requests to pass CSRF verification.
  get '/csrf_token', to: 'application#csrf_token'

  # --- Resource Management Routes ---
  # RESTful routes for locations with specific actions:
  # This defines standard routes for listing, showing, creating, updating, and deleting locations.
  resources :locations, only: [:index, :show, :create, :update, :destroy] do
    # Nested RESTful routes for customers under locations:
    # This means customers are always associated with a specific location in the URL.
    # E.g., GET /locations/:location_id/customers
    resources :customers, only: [:index, :update, :show, :destroy, :create] do
      # Nested RESTful routes for monthly consumptions under customers:
      # Monthly consumptions are associated with a specific customer and location.
      # E.g., POST /locations/:location_id/customers/:customer_id/monthly_consumptions
      resources :monthly_consumptions, only: [:index, :new, :show, :edit, :create, :update, :destroy]
    end
  end

  # Standalone routes for customers:
  # These routes allow you to access, update, or destroy customers directly by their ID,
  # without needing the parent location ID in the URL.
  # E.g., GET /customers/:id
  resources :customers, only: [:show, :update, :destroy]

  # --- Fallback Route ---
  # Fallback route to handle undefined routes:
  # This acts as a catch-all for any routes that don't match the above definitions.
  # It will direct such requests to the `route_not_found` action in your `ApplicationController`.
  # This is useful for providing a custom 404 error or a generic API fallback.
  match '*unmatched', to: 'application#route_not_found', via: :all
end