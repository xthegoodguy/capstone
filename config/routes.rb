Rails.application.routes.draw do
  get '/' => 'articles#index'
  get '/articles' => 'articles#index'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'


end
