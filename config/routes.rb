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
 	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
