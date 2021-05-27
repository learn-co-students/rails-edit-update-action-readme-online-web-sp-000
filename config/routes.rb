Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get 'articles/:id/edit', to: 'articles#edit', as: :edit_article
  # patch 'articles/:id', to: 'articles#update'
  # this line belw does the same as the two lines above, and then some
  resources :articles, only: [:index, :show, :new, :create, :edit, :update]
end
