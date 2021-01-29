Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #get 'articles', to: 'articles#index'
  #get 'articles/:id', to: 'articles#show'
  #get 'articles/new', to: 'articles#new', as: :new_article
  #post 'articles', to: 'articles#create'
  resources :articles, only: [:index, :show, :new, :create, :edit, :update]

  #get 'articles/:id/edit', to: 'articles#edit', as: :edit_article
  #Route to render the edit form
  #Internally referred to as edit_article_path(:id)
  #Appears as /articles/:id/edit

  #patch 'articles/:id', to: 'articles#update'
  #Route to update the object in the database 
  #Put can also be used IF you want to replace the entire thing.
end
