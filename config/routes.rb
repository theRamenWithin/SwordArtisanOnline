Rails.application.routes.draw do
  resources :listings

  get "orders/success", to: "orders#success"
  resources :orders

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  root to: "listings#index"
end
