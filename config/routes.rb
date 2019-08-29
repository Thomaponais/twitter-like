Rails.application.routes.draw do
  resources :tweets do
    member do
      get 'like'
      get 'unlike'
    end
  end
  resources :users do
    member do
      get 'follow'
      get 'unfollow'
    end
  end
  root :to => 'tweets#index'
  resources :user_sessions
  get 'user_index' => "users#index", as: :user_index
  resources :users
  get 'login' => 'user_sessions#new', as: :login
  delete 'logout' => 'user_sessions#destroy', as: :logout
  if Rails.env.production?
    get '*path', to: redirect('/'), constraints: lambda { |req|
      # 'rails/active_storage'が含まれているパスはリダイレクト対象外にする
      req.path.exclude? 'rails/active_storage'
    }
  end
end
