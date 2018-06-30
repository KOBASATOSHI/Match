Rails.application.routes.draw do
  get 'groups/new'

  get 'groups/edit'

  root 'sessions#new'
  get '/signup', to: 'users#new'
  post '/signup',  to: 'users#create'
  get '/login' , to: 'sessions#new'
  post '/login' , to: 'sessions#create'
  delete '/logout' , to: 'sessions#destroy'

  resources :users 
  resources :groups
  resources :favorites do
    collection do
      get :favoring, :favored, :matched
    end
    member do
      get :match, :not_match
    end
  end
end
