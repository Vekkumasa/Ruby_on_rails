Rails.application.routes.draw do
  resources :beer_clubs
  resource :session, only: [:new, :create, :destroy]
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'
  resources :users
  get 'signup', to: 'users#new'
  root 'breweries#index'
  resources :beers
  resources :breweries
#  get 'ratings', to: 'ratings#index'
#  get 'ratings/new', to:'ratings#new'
#  post 'ratings', to: 'ratings#create'
  resources :ratings, only: [:index, :new, :create, :destroy]
end
