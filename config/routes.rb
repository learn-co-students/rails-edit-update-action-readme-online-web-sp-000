Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get 'articles', to: 'articles#index'

  # get 'articles/new', to: 'articles#new'

  # get 'articles/:id', to: 'articles#show'

  # post 'articles', to: 'articles#create'

  # get 'articles/:id/edit', to: 'articles#edit', as: :edit_article

  # patch 'articles/:id', to: 'articles#update'

  resources :articles, only: [:index, :show, :new, :create, :edit, :update]
end
