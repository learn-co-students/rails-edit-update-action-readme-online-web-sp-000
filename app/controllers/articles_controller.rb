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
    @article = Article.new(title: params[:title], description: params[:description])
    if @article.save
      redirect_to article_path(@article)
    else
      render :new
    end
  end

  # add edit and update methods here
  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(:title => params[:article][:title], :description => params[:article][:description])
      redirect_to article_path(@article)
    else
      render :edit
    end
  end

  private
    def article_params

end
