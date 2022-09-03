Rails.application.routes.draw do
  devise_for :users
  # user resource 
  resources :users 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'landing#index'

  resources :rooms

  get '/landing/broadcast'
  post '/landing/broadcast', to: 'landing#broadcast'

end
