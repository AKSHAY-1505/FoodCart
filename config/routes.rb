Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :foods
  resources :customers, only: %i[edit update]
  resources :carts, only: [:show]
  resources :orders, only: %i[create update index new]
  resources :order_items, only: %i[create update index new destroy]
  resources :cart_items, only: %i[create destroy]
  resources :delivery_agents, only: %i[new create]
  resources :promotions, only: %i[new create edit update destroy]
  resources :addresses, only: %i[create]
  resources :categories, only: %i[create]
  resources :coupons, only: %i[index new create destroy update]

  get 'up' => 'rails/health#show', as: :rails_health_check
  root 'customers#home'

  get '/admin' => 'admins#home', as: :admin_home
  get '/delivery_agent' => 'delivery_agents#home', as: :delivery_agent_home
  get '/customer/food/:id' => 'customers#view_food', as: :view_food
  get '/myorders' => 'customers#customer_orders', as: :customer_orders
  patch '/admin/assignAgent/:id' => 'orders#assign_agent', as: :assign_agent
  get 'reports/download' => 'reports#download', as: :download_report
  post '/applyCoupon' => 'carts#apply_coupon', as: :apply_coupon
  post '/removeCoupon' => 'carts#remove_coupon', as: :remove_coupon
end
