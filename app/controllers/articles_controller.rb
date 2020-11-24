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

  def edit
    @article = Article.find(params[:id])
    # if you run 'rails routes', you'll see that the edit URI contains :id (which you can access in the params)


  end

  def update
    # raise params.inspect (prints params on an error page)
    @article = Article.find(params[:id])
    #@article.update(title: params[:article][:title], description: params[:article][:description])
    params[:article].permit! # why was params[:article] a forbidden attribute?
    @article.update(params[:article])

    redirect_to article_path(@article)
  end
end
