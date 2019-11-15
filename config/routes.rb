Rails.application.routes.draw do
  resources :articles, only: [:new, :show, :index, :create]
  get 'articles/:id/edit', to: 'articles#edit', as: :edit_article 
  patch 'articles/:id', to: 'articles#update'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
