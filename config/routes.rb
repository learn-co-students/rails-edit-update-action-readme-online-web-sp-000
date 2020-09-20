Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   resources :articles, only: [:index, :show, :new, :create, :edit, :update]
  # get 'articles',  to: 'articles#index'
  # get 'articles/new', to: 'articles#new'
  # get 'article', to: 'articles#create'
  # get 'articles/:id/edit', to: 'articles#edit', as: :edit_article
  # patch 'articles/:id', to: 'articles#update'
end
