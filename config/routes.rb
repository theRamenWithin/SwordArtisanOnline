Rails.application.routes.draw do
  resources :listings

  get "orders/success", to: "orders#success"
  resources :orders

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  root to: "listings#index"
end
