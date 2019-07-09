Rails.application.routes.draw do
  resources :tweets
  root :to => 'tweets#index'
  resources :user_sessions
  resources :users

  get 'login' => 'user_sessions#new', as: :login
  delete 'logout' => 'user_sessions#destroy', as: :logout

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
