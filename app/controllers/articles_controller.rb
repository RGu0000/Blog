class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_user, only: %i[create destroy edit]
  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      flash[:notice] = 'You have added a new article.'
      redirect_to(@article)
    else
      flash[:danger] = 'Failed to add new article.'
      render :new
    end
  end

  def edit

  end

  def destroy
    @article = Article.find(params[:id]).destroy
    redirect_to articles_path
  end

  def show
    @article = Article.find(params[:id]).decorate
  end

  private

  def article_params
    params.require(:article)
          .permit(:body, :title, :tag_list, :user_id)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
