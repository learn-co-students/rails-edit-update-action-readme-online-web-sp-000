Rails.application.routes.draw do
  resources :articles, only: %i[index show new create edit update]
end
