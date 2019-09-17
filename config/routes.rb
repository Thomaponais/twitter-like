Rails.application.routes.draw do
  resources :tweets do
    member do
      get 'like'
      get 'unlike'
      get 'reply'
    end
  end
  resources :users do
    member do
      get 'follow'
      get 'unfollow'
    end
  end
  root to: 'tweets#index'
  resources :user_sessions, only: [:new, :create, :destroy]
  get 'user_index', to: "users#index", as: :user_index
  resources :users
  get 'login', to: 'user_sessions#new', as: :login
  delete 'logout', to: 'user_sessions#destroy', as: :logout
  if Rails.env.production?
    get '*path', to: redirect('/'), constraints: lambda { |req|
      # 'rails/active_storage'が含まれているパスはリダイレクト対象外にする
      req.path.exclude? 'rails/active_storage'
    }
  end
end
