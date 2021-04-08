Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :articles, only: [:index, :show, :new, :create, :edit, :update]
  # the following 2 lines accomplish the same functionality as the line above
  # get 'articles/:id/edit', to: 'articles#edit', as: :edit_article
  # patch 'articles/:id', to: 'articles#update'
end
