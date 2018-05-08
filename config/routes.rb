Rails.application.routes.draw do
  get 'tags/:name', to: 'tags#show_name', as: "tag_name"

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :tags, only: %i[index]
  resources :users, only: %i[index show]
  resources :articles
  root 'articles#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
