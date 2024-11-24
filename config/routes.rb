Rails.application.routes.draw do
  # Defines RESTful routes for locations, customers, and nested resources for monthly consumptions
  resources :locations do
    resources :customers, shallow: true do
      resources :monthly_consumptions, shallow: true
    end
  end

  # You can define a root path or additional custom routes if needed
  root "locations#index"
end

