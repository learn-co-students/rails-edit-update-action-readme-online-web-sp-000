Rails.application.routes.draw do

  resources :articles, only: [:create, :edit, :index, :new, :show, :update]

end
