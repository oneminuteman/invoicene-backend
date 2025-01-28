Rails.application.routes.draw do
  # Defines RESTful routes for locations, customers, and nested resources for monthly consumptions
  resources :locations do
    resources :customers, shallow: true do
      resources :monthly_consumptions, shallow: true
    end
  end

  # Root path points to the index action of LocationsController
  root "locations#index"
end


