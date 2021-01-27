class ArticlesController < ApplicationController

def edit
  @article = Article.find(params[:id])
end

def update
  @article = Article.find(params[:id])
  @article.update(title: params[:article][:title], description: params[:article][:description])
  redirect_to article_path(@article)
end

def new 
end 

def show 
  @article = Article.find(params[:id])
end

def create 
  @article = Article.create(:title => params[:title], description: params[:description])
  
  redirect_to articles_path
end 

def index 
  @article = Article.all 
end 
end
