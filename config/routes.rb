Rails.application.routes.draw do
  resources :foods
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :customers, only: %i[edit update]
  resources :carts, only: [:show]
  resources :orders, only: %i[create update index]
  resources :cart_items, only: %i[create destroy]
  resources :delivery_agents, only: %i[new create]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  root 'customers#home'
  get '/admin' => 'admins#home', as: :admin_home
  get '/delivery_agent' => 'delivery_agents#home', as: :delivery_agent_home
  get '/myorders' => 'customers#customer_orders', as: :customer_orders
  patch '/admin/assignAgent/:id' => 'orders#assign_agent', as: :assign_agent
end
