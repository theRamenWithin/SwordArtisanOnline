Rails.application.routes.draw do
  resources :listings
  resources :orders
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  root to: "listings#index"
end
