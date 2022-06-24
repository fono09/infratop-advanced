Rails.application.routes.draw do
  resources :books
  root 'homes#top'
end
