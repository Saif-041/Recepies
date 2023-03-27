Rails.application.routes.draw do

  root "pages#home"
  get "pages/home", to: 'pages#home'

  resources :recipes

  # get '/recipes', to: 'recipes#index'
  # get '/recipes/new', to: 'recipes#new', as: 'new_recipe'
  # get '/recipes/:id', to: 'recipes#show', as: 'recipe'

  get '/signup', to: 'chefs#new'
  resources :chefs, except: [:new]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :ingredients, except: [:destroy]
end
