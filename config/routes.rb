Rails.application.routes.draw do
  get 'contacts/new'
  get 'contacts/create'
  get 'dogsnew', to: 'dogs#new'
  post 'dogsnew', to: 'dogs#create'
  resources :dogs
  root 'static_pages#home'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  resources :users do
    member do
      get :following, :followers, :friends
    end
    get :search
  end
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show]
  resources :likes, only: [:create, :destroy, :index]
end
