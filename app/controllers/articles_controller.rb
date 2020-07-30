class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new
    @article.title = params[:title]
    @article.description = params[:description]
    @article.save
    redirect_to article_path(@article)
  end

# add edit and update methods here
# Since the form will need to know which record is being edited, this will need to be a dynamic route that accepts an :id as a parameter that the controller can access:
# route: get 'articles/:id/edit', to: 'articles#edit', as: :edit_article
# Since @article is not a new instance of Article, the inputs on this form, the text field and text area, will be populated with the corresponding object values.
  def edit
    @article = Article.find(params[:id])
  end

# This second route will also need to be dynamic, accepting the same :id as a parameter so that the action will know which record is being altered.
# PATCH: we're sending data to the server
# route: patch 'articles/:id', to: 'articles#update'
# update action:
# query database for Article record that matches :id passed to route
# store query in instance varaible
# update values passed from form The update method takes a hash of the attributes for the model as its argument, e.g. `Article.find(1).update(title: "I'm Changed", description: "And here too!")
# save changes in the database
# redirect the user to the show page
def update
# raise params.inspect The raise method will cause the application to pause and print out the params on an error page
@article = Article.find(params[:id])
 @article.update(title: params[:article][:title], description: params[:article][:description])
 redirect_to article_path(@article)
end
# Now if you go to the edit page and make changes to the title or description form elements, you will see they are changed when the form is submitted.

end
