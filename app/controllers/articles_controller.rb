class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end

  def create
    @article = Article.new
    @article.author_id = 2
    @article.update_attributes(article_params)
    if @article.save
      flash[:notice] = 'You have added a new article.'
    else
      flash[:danger] = 'Failed to add new article.'
    end
  end

  def index
    @articles = Article.all
  end

  def destroy
    @article = Article.find(params[:id]).destroy
    redirect_to articles_path
  end

  def show
    @article = Article.find(params[:id])
  end

  private

  def article_params
    params.require(:article).permit(:body, :title)
  end
end
