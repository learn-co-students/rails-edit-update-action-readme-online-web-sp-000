Rails.application.routes.draw do
  resources :articles, only: %i[index show new create edit update]

  # Added the following lines to the resources
  # get 'articles/:id/edit', to: 'articles#edit', as: :edit_article
  # patch 'articles/:id', to: 'articles#update'

end
