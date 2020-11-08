Rails.application.routes.draw do
  resources :listings
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  root to: "listings#index"
end
