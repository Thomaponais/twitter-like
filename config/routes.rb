Rails.application.routes.draw do
  resources :tweets
  root :to => 'tweets#index'
  resources :user_sessions
  get 'user_index' => "users#index", as: :user_index
  resources :users

  get 'login' => 'user_sessions#new', as: :login
  delete 'logout' => 'user_sessions#destroy', as: :logout

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
