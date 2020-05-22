require 'pry'
class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(article_params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    # @article.title = article_params[:title]
    # @article.description = article_params[:description]
    @article.save
    redirect_to article_path(@article)
  end

  # add edit and update methods here
  def edit 
    @article = Article.find(article_params[:id])
  end 

  def update 
    @article = Article.find(article_params[:id])
    @article.update(article_params)
    @article.save 
    redirect_to article_path(@article)
  end 
  
  private 
    def article_params 
      params.permit(:id, :title, :description)
    end 
end








