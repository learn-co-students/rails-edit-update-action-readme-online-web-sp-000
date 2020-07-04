# Edit/Update Action

## Rails Controller Conventions

Now that you know how to implement a create action, the next logical step will
be to integrate an edit/update action. As you may have noticed, there is a trend
in Rails conventions where the logic for rendering a form is separate from the
action that manages the database record alteration. For example:

- The `new` action in the controller simply renders the `new` form

- The `create` action is what actually handles the process of inserting the form
  data into the database

In like fashion, the `edit` and `update` actions have a similar convention:

- The `edit` action will handle rendering the `edit` form

- The `update` action will be the method that updates the database record itself

## Rendering the `edit` form

To start off, let's draw a `get` route for our edit form. Since the form will
need to know which record is being edited, this will need to be a dynamic route
that accepts an `:id` as a parameter that the controller can access:

```ruby
get 'articles/:id/edit', to: 'articles#edit', as: :edit_article
```

We still need to draw one additional route to handle the `update` action. This
second route will also need to be dynamic, accepting the same `:id` as a
parameter so that the action will know which record is being altered. If you're
curious about which HTTP verb should be selected, consider the following: we're
sending data to the server, so we know it's not `GET`, and since we're not
creating a new record it shouldn't be `POST`. That's right- `PATCH` should be the
HTTP verb!

```ruby
patch 'articles/:id', to: 'articles#update'
```

**Note:** What about `PUT`? `PUT` will actually work just fine here, but briefly,
`PUT` is meant to be used when replacing a whole resource. `PATCH`, on the other
hand, is for used for sending a set of changes to a resource.

If you run `rake routes`, you will see we have some new routes:

```bash
Prefix      Verb  URI Pattern               Controller#Action
                        ...
edit_article   GET  /articles/:id/edit(.:format) articles#edit
          PATCH  /articles/:id(.:format)      articles#update
```

On a side note, as a shortcut you could also simply add the `edit` and `update`
actions to the `resources` call in the routes file. That would accomplish the
same goal that these two lines do:

```ruby
  resources :articles, only: [:index, :show, :new, :create, :edit, :update]
```

This will give you the same routes along with a `PUT` route for
`articles#update`.

With our routes in place, let's add in the controller actions...

```ruby
def edit
end

def update
end
```

...and then create the edit view template in `app/views/articles/edit.html.erb`.
Let's just copy and paste the `new` form:

```erb
<%= form_tag articles_path do %>
  <label>Article title:</label><br>
  <%= text_field_tag :title %><br>

  <label>Article Description</label><br>
  <%= text_area_tag :description %><br>

  <%= submit_tag "Submit Article" %>
<% end %>
```

If you open the browser and go to the `edit` page, it will now display the form,
but you may have noticed a pretty big flaw. It doesn't load the record's data
into the form! There are a few things that we'll need to do in order to
implement this behavior. First, let's have our `edit` action store the `article`
record in an instance variable:

```ruby
def edit
  @article = Article.find(params[:id])
end
```

Now that the `edit` view template will have access to the `Article` object (stored
in `@article`), we need to refactor the form so that it auto-fills the form fields
with the corresponding data from `@article`. We'll also use a different form helper, `form_for`, which will automatically set up the url where the form will be sent. These changes can be seen below:

```erb
<% # app/views/articles/edit.html.erb %>

<%= form_for @article do |f| %>
  <%= f.label 'Article Title' %><br>
  <%= f.text_field :title %><br>

  <%= f.label 'Article Description' %><br>
  <%= f.text_area :description %><br>

  <%= f.submit "Submit Article" %>
<% end %>
```

In this case, `form_for` takes care of some work for us. Using the object
`@article` we've provided, `form_for` determines that `@article` is **not a _new_
instance** of the `Article` class. Because of this, `form_for` knows to
automatically send to the _update_ path.

Since `@article` is not a new instance of `Article`, the inputs on this form, the text
field and text area, will be populated with the corresponding object values.

When submitted, the form will be routed to the `update` action. Before we
try to implement the `update` action, let's first make sure the data is being
routed properly. Enter the following code inside of the `update` method:

```ruby
def update
  raise params.inspect
end
```

The `raise` method will cause the application to pause and print out the
`params` on an error page. You could also see the `params` if you called `puts params.inspect`; using `puts` would simply require you to track down the data in
the Rails server log.

If you open up the browser, navigate to an edit page (such as
`localhost:3000/articles/2/edit`), change some elements in the form, and submit it,
it should take you to an error page that prints out the params from the form,
such as in the below image:

![Raised Exception for Update Action](https://i.imgur.com/38MhjpO.png)

As you can see, the parameters are being passed to the `update` action. With
that in mind, let's implement the functionality needed inside of the `update`
action so that it will take the form data and update the specified record. Let's
sketch out a basic flow for what the `update` action should do:

- Query the database for the `Article` record that matches the `:id` passed to the route.

- Store the query in an instance variable.

- Update the values passed from the form (the update method here is the `update`
  method supplied by Active Record, not the `update` method we're creating). **The
  update method takes a hash of the attributes for the model as its argument, e.g.
  `Article.find(1).update(title: "I'm Changed", description: "And here too!")**

- Save the changes in the database.

- Redirect the user to the `show` page so they can see the updated record.

We'll take advantage of Active Record's `update` method so that we're not
manually assigning each attribute:

```ruby
def update
  @article = Article.find(params[:id])
  @article.update(title: params[:article][:title], description: params[:article][:description])
  redirect_to article_path(@article)
end
```

Now if you go to the `edit` page and make changes to the `title` or
`description` form elements, you will see they are changed when the form is
submitted. The `edit` and `update` functions are working properly!

## Extra Credit

- When only one form element is updated, such as the `title`, does the
  `description` also get updated?

- How could we refactor this form code? You may notice that we have a form for the
  `new` and `edit` actions. Is there a better way of doing this?

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/rails-edit-update-action-readme' title='Edit/Update Action'>Edit/Update Action</a> on Learn.co and start learning to code for free.</p>

<p class='util--hide'>View <a href='https://learn.co/lessons/rails-edit-update-action-readme'>Edit/Update Action</a> on Learn.co and start learning to code for free.</p>
