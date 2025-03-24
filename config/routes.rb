Rails.application.routes.draw do
  resources :villas, only: [ :index, :show ]

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA-related routes
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path
  # root "villas#index"
end
