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

  def edit #let's have our edit action store the article record in an instance variable
    @article = Article.find(params[:id])
    #Now that the edit view template will have access to the Article object (stored in @article),
    # we need to refactor the form so that it auto-fills the form fields with the corresponding data from @article
  end
   
  def update #it will take the form data and update the specified record
    #raise params.inspect - raise method will cause the application to pause and print out the params on an error page
    #puts params.inspect; using puts would simply require you to track down the data in the Rails server log.
    @article = Article.find(params[:id]) # Query the database for the Article record that matches the :id passed to the route and store the query in an instance variable
    #Update the values passed from the form (the update method here is the update method supplied by Active Record, not the update method we're creating).
    @article.update(title: params[:article][:title], description: params[:article][:description])#The update method takes a hash of the attributes for the model as its argument
    #Save the changes in the database.
    #Redirect the user to the show page so they can see the updated record.
    redirect_to article_path(@article)
  end
end
