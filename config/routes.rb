Rails.application.routes.draw do
  resources :articles, only: [:index, :show, :new, :create]
  patch 'articles/:id', to: 'articles#update'
  get 'articles/:id/edit', to: 'articles#edit', as: :edit_article
end
