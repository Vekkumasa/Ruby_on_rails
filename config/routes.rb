Rails.application.routes.draw do
  resources :styles
  resources :places, only: [:index, :show]
  post 'places', to: 'places#search'
  resources :memberships
  resources :beer_clubs
  resource :session, only: [:new, :create, :destroy]
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'
  resources :users
  resources :users do
    post 'toggle_closed', on: :member
  end
  get 'signup', to: 'users#new'
  root 'breweries#index'
  resources :beers
  resources :breweries
  resources :breweries do
    post 'toggle_activity', on: :member
  end
#  get 'ratings', to: 'ratings#index'
#  get 'ratings/new', to:'ratings#new'
#  post 'ratings', to: 'ratings#create'
  resources :ratings, only: [:index, :new, :create, :destroy]
end
