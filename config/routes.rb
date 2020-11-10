Rails.application.routes.draw do
  resources :listings

  resources :orders
  get "/orders/success", to: "orders#success"


  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  root to: "listings#index"
end
