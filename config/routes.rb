Rails.application.routes.draw do
  get 'sessions/new'

  resources :users

  root "static_pages#home"	
  get '/home', to: 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/help', to: 'static_pages#help'
  get '/contact', to: 'static_pages#contact'

  get '/signup', to: 'users#new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete  '/login', to: 'sessions#destory'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
