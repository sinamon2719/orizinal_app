Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  get 'items/show'
  root to: 'items#index'
  resources :users
  resources :items
end