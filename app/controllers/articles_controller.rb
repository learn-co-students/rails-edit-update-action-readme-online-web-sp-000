class ArticlesController < ApplicationController
  before_filter :find_article, only: [:show, :edit, :update]
  def index
    @articles = Article.all
  end

  def show
    
  end

  def new
    @article = Article.new
  end

  def create
    byebug
    
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def edit
    
  end

  def update
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  private

  def remove_blank(args)
    args.transform_values!{|x| x=nil if x.blank?}
  end

  def article_params
    remove_blank params.require(:article).permit(:title, :description)
  end

  def find_article
    @article = Article.find(params[:id])
  end

end
