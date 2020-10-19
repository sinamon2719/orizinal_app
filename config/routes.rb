Rails.application.routes.draw do
  get 'users/show'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy" 
  end

  root to: 'items#index'
  get 'items/search'
  resources :users do
    member do
      get 'likes'
    end
  end
  get '/mypage' => 'users#mypage'
  
  resources :items do
    collection do
      get 'recommend'
    end
    collection do
      get 'category_seach'
    end
    collection do
      get 'category_all'
    end
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
  resources :items do
    resources :orders, only: [:create, :index]
  end
  resources :items do
    resources :comments, only: :create
  end
  resources :items do
    resource :likes, only: [:create, :destroy]
  end
  
end