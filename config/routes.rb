Rails.application.routes.draw do
  # Root route: Directs to the index action of LocationsController
  root "locations#index"

  get '/favicon.ico', to: redirect('/assets/favicon.ico')


  # RESTful routes for locations
  resources :locations, only: [:index, :show, :create, :update, :destroy] do
    # Nested RESTful routes for customers under locations
    resources :customers, only: [:index, :update, :show, :destroy, :create] do
      # Nested RESTful routes for monthly consumptions under customers
      resources :monthly_consumptions, only: [:index, :new, :show, :edit, :create, :update, :destroy]
    end
  end

  # Standalone routes for customers
  resources :customers, only: [:show, :update, :destroy]

  # Fallback route to handle undefined routes (Optional, for debugging or API fallback)
  match '*unmatched', to: 'application#route_not_found', via: :all
end



