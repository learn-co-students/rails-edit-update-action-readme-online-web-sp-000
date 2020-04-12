Rails.application.routes.draw do
  resources :articles, only: [:index, :show, :new, :create]
  get 'articles/:id/edit', to: 'articles#edit', as: :edit_article
  patch 'articles/:id', to: 'articles#update'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
