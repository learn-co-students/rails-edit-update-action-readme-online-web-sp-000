Rails.application.routes.draw do
  resources :articles, only: [:index, :show, :new, :create, :edit, :update]
  # get 'articles/:id/edit', to: 'articles#edit', as: :edit_article
  # patch 'articles/:id', to: 'articles#update'
end
