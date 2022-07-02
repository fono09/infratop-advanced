Rails.application.routes.draw do
  root "homes#top"
  get "/home/about" =>  "homes#about"

  devise_for :users
  resources :users, only: [:index, :show, :edit, :update]
  resources :users do
    resource :relationship, only: [:create, :destroy]
    member do
      get :followers
      get :follows
    end
  end
  get '/search' => "searches#search"

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update]
  resources :books do
    resource :favorite, only: [:create, :destroy]
  end
  resources :book_comments, only: [:create, :destroy]
end
