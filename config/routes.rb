Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :articles, only: [:index, :show, :new, :create, :edit, :update]
  #get 'articles/:id/edit' => 'articles#edit', as: "edit_article"
  #patch 'articles/:id' => 'articles#update'
end
