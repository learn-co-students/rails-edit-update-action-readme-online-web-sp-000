Rails.application.routes.draw do
  #let's draw a get route for our edit form
  #Since the form will need to know which record is being edited,
  # this will need to be a dynamic route that accepts an :id as a parameter that the controller can access
      #get 'articles/:id/edit', to: 'articles#edit', as: :edit_article
  #additional route to handle the update action. This second route will also need to be dynamic, accepting the same :id
  #we're sending data to the server, so we know it's not GET, and since we're not creating a new record it shouldn't be POST.
  #PATCH should be the HTTP verb
      #patch 'articles/:id', to: 'articles#update'
  #PUT will actually work just fine here, but briefly, PUT is meant to be used when replacing a whole resource.
  #PATCH, on the other hand, is for used for sending a set of changes to a resource.

    resources :articles, only: [:index, :show, :new, :create, :edit, :update]
end
