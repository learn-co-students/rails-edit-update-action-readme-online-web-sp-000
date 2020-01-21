Rails.application.routes.draw do
  patch 'articles/:id', to: 'articles#update'

  resources :articles, only: [:index, :show, :new, :create, :edit, :update]
end
