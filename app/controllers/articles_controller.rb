class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_user, only: %i[destroy edit]

  def index
    @articles = Article.all
    render :index
  end

  def show
    @article = Article.find(params[:id]).decorate
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
      # render :new
    end
    # HerokuBlogpost::Creator.new(
    #   title: 'Hi!',
    #   categories: 'Computer, Friends',
    #   content: 'Blog post content'
    # ).call
  end

  def edit; end

  def update
    @article = Article.find(params[:id])
    @article.update_attributes(article_params)
    if @article.save
      redirect_to article_path(@article)
      flash[:success] = 'Article updated'
    else
      flash[:error] = 'Article updated'
    end
  end

  def destroy
    flash[:success] = 'Article deleted' if @article.destroy
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article)
          .permit(:body, :title, :tag_list)
          .merge(author_id: current_user.id)
  end

  def set_user
    @article = Article.find(params[:id])
    if current_user.id == @article.author_id
      @author = current_user
    else
      redirect_to article_path(@article), message: 'You can\'t do that'
    end
  end
end
