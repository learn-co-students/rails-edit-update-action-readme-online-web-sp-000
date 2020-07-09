Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #get route
  #get 'articles/:id/edit', to: 'articles#edit', as: :edit_article
  #patch route
  #patch 'articles/:id', to: 'articles#update'
  #or
  resources :articles, only: [:index, :show, :new, :create, :edit, :update]
end
