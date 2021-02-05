Rails.application.routes.draw do
  resources :articles, only: [:index, :show, :new]
  get 'articles/:id/edit', to: 'articles#edit', as: :edit_article
  get 'articles/new', to: 'articles#new'
  post 'articles', to: 'articles#create'
  patch 'articles/:id', to: 'articles#update'
end
