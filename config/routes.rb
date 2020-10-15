Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # how to manually edit an article by :id
  # get 'articles/:id/edit', to: 'articles#edit', as: :edit_article

  # how to manually update an article by :id
  # patch 'articles/:id', to: 'articles#update'

  resources :articles, only: [:index, :show, :new, :create, :edit, :update]

end
