Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root to: 'items#index'
  resources :users

  resources :items do
    collection do
      get 'education'
    end
    collection do
      get 'appliances'
    end
    collection do
      get 'cosmetics'
    end
    collection do
      get 'fashion'
    end
    collection do
      get 'food'
    end
    collection do
      get 'hobby'
    end
  end
end