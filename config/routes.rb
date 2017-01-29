Rails.application.routes.draw do
  get 'sessions/new'

  resources :users

  root "static_pages#home"	
  get '/home', to: 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/info', to: 'static_pages#info'
  get '/vr_ar', to: 'static_pages#vr_ar'
  get '/ai', to: 'static_pages#ai'
  get '/fun', to: 'static_pages#fun'

  get '/signup', to: 'users#new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete  '/logout', to: 'sessions#destroy'

  resources :account_activations, only: [:edit] 
  resources :microposts,          only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
