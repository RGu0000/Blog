Rails.application.routes.draw do
  get 'startup/index'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :tags, only: %i[show index]
  resources :users
  resources :articles
  root 'articles#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
