Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  patch 'articles/:id', to: 'articles#update'

  resources :articles, only: [:index, :new, :show , :create, :edit, :update]
end
