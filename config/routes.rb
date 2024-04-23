Rails.application.routes.draw do
  resources :foods
  devise_for :users, controllers: {
        registrations: 'users/registrations'
      }
  resources :customers, only: [:edit,:update]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "customers#home"
  get "/admin" => "admins#home", as: :admin_home
end
