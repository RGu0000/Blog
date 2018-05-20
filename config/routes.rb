Rails.application.routes.draw do
  root 'articles#index'

  devise_for :users, controllers: {
    registrations: 'override_devise/registrations'
  }
  resources :tags, only: %i[index]
  resources :users, only: %i[index show]
  resources :articles do
    resources :comments, only: %i[create destroy]
    resources :ratings, only: %i[new create edit update]
  end

  get 'tags/:name', to: 'tags#show_name', as: "tag_name"
  get 'articles/:article_id/comments/new/(:parent_id)', to: 'comments#new', as: :new_comment
  # post 'article/:article_id/user_id/:user_id/rate/:rate', to: 'ratings#rate', as: 'rate_article'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
