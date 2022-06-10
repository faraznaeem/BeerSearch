Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "beers#index"
  resources :beers, only: [:index, :show]
  get '/search', to: 'beers#search_beer'
end
