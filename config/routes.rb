Rails.application.routes.draw do
  root 'welcome#index'

  devise_for :users, controllers: {
    registrations: 'override_devise/registrations'
  }

  resources :tags, only: %i[index]
  resources :users, only: %i[index show]

  resources :articles do
    resources :comments, only: %i[create destroy]
    resources :ratings, only: %i[new create edit update]
    resources :bookmarks, only: %i[create destroy]
  end

  get 'tags/:name', to: 'tags#show_name', as: "tag_name"
  get 'articles/:article_id/comments/new/(:parent_id)', to: 'comments#new', as: :new_comment

  namespace :api do
    namespace :v1 do
      resources :articles, only: [:index, :show]
    end
  end

end
