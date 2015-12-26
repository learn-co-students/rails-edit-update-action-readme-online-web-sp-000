# Edit/Update Action

## Rails Controller Conventions

Now that you know how to implement a create action the next logical step will be to integrate an edit/update action. As you may have noticed, there is a trend in Rails conventions where the logic for rendering a form is separate from the action that the manages the database record alteration. For example:

* The `new` action in the controller simply rendering the `new` form

* The `create` action is what actually handled the process for inserting the form data into the database

In like fashion, the `edit` and `update` actions have a similar convention:

* The `edit` action will handle rendering the `edit` form

* The `update` action will be the method that updates the database record itself


## Rendering the `edit` form

To start off, let's draw a `get` route for our edit form, since the form will need to know which record is being edited this will need to be a dynamic route that accepts an `:id` as a parameter so it can be accessed by the controller:

```ruby
get '/post/:id/edit', to: 'posts#edit'
```

We still need to draw one additional route to handle the `update` action, this route will also need to be dynamic and accept an `:id` as a parameter so the `update` action will know what record is being altered. If you're curious on what HTTP verb should be selected, consider that we're sending data to the server, so we know it's not `GET`, and since we're not creating a new record it shouldn't be `POST`, so `PUT` should be the HTTP verb.

```ruby
put 'post/:id', to: 'posts#update'
```

If you run `rake routes` you will see we have two new routes:

```
Verb    URI Pattern                 Controller#Action
GET     /post/:id/edit(.:format)    posts#edit
PUT     /post/:id(.:format)         posts#update
```

With our routes in place, let's add in the controller actions:

```ruby
def edit
end

def update
end
```

And then create the edit view template `app/views/posts/edit.html.erb`

Let's just copy and paste the form code from the `new` form:

```ERB
<h3>Post Form</h3>

<%= form_tag posts_path do %>
  <label>Post title:</label><br>
  <%= text_field_tag :title %><br>

  <label>Post Description</label><br>
  <%= text_area_tag :description %><br>

  <%= hidden_field_tag :authenticity_token, form_authenticity_token %>
  
  <%= submit_tag "Submit Post" %>
<% end %>
```

If you open the browser and go to the `edit` page it will now display the form, but you may have noticed a pretty big flaw, it doesn't load the record's data into the form, there are a few tasks that we'll need to do in order to implement this behavior, first let's have our `edit` action store the `post` record in an instance variable:

```ruby
def edit
  @post = Post.find(params[:id])
end
```

Now that the `edit` view template will have access to the `@post` object, we need to refactor the form so that it auto fills the form fields with the data from the `post` record, this is done below:

```ERB
<% # app/views/posts/edit.html.erb %>

<h3>Post Form</h3>

<%= form_for(@post) do |f| %>
  <label>Post title:</label><br>
  <%= f.text_field :title %><br>

  <label>Post Description</label><br>
  <%= f.text_area :description %><br>
  
  <%= f.submit %>
<% end %>
```

This will now populate the form, but if you tried to submit the form you may notice that it's redirecting to the show page and not changing the values. Notice how the `post_path` route helper method is used for the `show`, `update`, `edit`, and `delete` method? How can we let the app know that we want to use the `update` method in this case? We need to first make a change to the form so that it knows what route the data should be passed through as well as what HTTP verb needs to be called, make the following change to the `form_tag` line:

```ERB
<%= form_tag post_path(@post), method: "put" do %>
```

By explicitly stating the route and method the form will now be routed to the `update` action. Before we try to implement the `update` action, let's first make sure the data is being routed properly. Enter the following code inside of the `update` method:

```ruby
def update
  raise params.inspect
end
```

The `raise` method will cause the application to pause and print out the `params`, you could also see the `params` if you called `puts params.inspect`, using `puts` would simply require you to track down the data in the rails server session.

If you open up the browser and navigate to an edit page, such as: `localhost:3000/post/5/edit` and change some elements in and form and submit it, it should take you to an error page that prints out the params from the form, such as the below image:

![Raised Exception for Update Action](http://reif.io/lib/flatiron/update_raised_exception.png)

As you can see, the parameters are being passed to the update action, with that in mind let's implement the functionality needed inside of the `update` action so that it will take the form data and update the specified record. Let's write some pseudo code for what the `update` action should do:

* Query the database for the `Post` record that matched the `:id` passed to the route

* Store the query in an instance variable

* Update the values passed from the form (the update method here is the `update` method supplied from `ActiveRecord`, not the `update` method we're creating). **The update method takes a hash of the attributes for the model as its argument, e.g. `Post.find(1).update(title: "I'm Changed", description: "And here too!")**

* Save the changes in the database

* Redirect the user to the `show` page so they can see the updated record


We'll take advantage of the `update` method so that we're not manually assigning each attribute:

```ruby
def update
  @post = Post.find(params[:id])
  @post.update(params)
  redirect_to post_path(@post)
end
```

Now if we run this in the browser we'll get the following error: `ActiveModel::ForbiddenAttributesError in PostsController#update`. So what's going on here? In Rails 4+, Rails forces you to whitelist the attributes that are sent in the form and added to the database, this is to prevent hackers from submitting malicious form parameter values. This error is easily fixed by adding in the parameters we want whitelisted into the `update` method:

```ruby
def update
  @post = Post.find(params[:id])
  @post.update(params)
  redirect_to post_path(@post)
end
```

**Note, you will need to disable strong params for this to work if you're following along, you can do this by adding this line `config.action_controller.permit_all_parameters = true` in the `config/application.rb` file. We'll gett into strong parameters in a later lesson.**

Now if you go to the edit page and make changes to the `title` or `description` form elements you will see they are changed when the form is submitted, so the `edit` and `update` functions are working properly!


## Extra Credit

* When only one form element is updated, such as the `title`, does the `description` also get updated?

* How could we refactor this form code? You may notice that we have a form for the `new` and `edit` actions, is there a better way of doing this?