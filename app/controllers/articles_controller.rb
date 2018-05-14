class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_user, only: %i[destroy edit update]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 25)
  end

  def show
    @article = Article.find(params[:id]).decorate
    @comments = Comment.includes(:author, :children, :article).where(article_id: @article.id).hash_tree
    @comment = Comment.new
  end

  def new
    @article = Article.new
    @article_form = ArticleForm.new(@article)
  end

  def create
    @article = Article.new
    @article_form = ArticleForm.new(@article)
    if @article_form.save(article_params)
      flash[:notice] = 'You have added a new article.'
      redirect_to @article_form.article
    else
      flash[:danger] = 'Failed to add new article.'
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
    @article_form = ArticleForm.new(@article)
    # binding.pry
  end

  def update
    @article = Article.find(params[:id])
    @article_form = ArticleForm.new(@article)
    if @article_form.save(article_params)
      flash[:success] = 'Article updated'
      TagServices::OrphanTagDestroyer.call
      redirect_to @article_form.article
    else
      flash[:error] = 'Failed to update the article'
      render :edit
    end
  end

  def destroy
    if @article.destroy
      flash[:success] = 'Article deleted'
      TagServices::OrphanTagDestroyer.call
      redirect_to articles_path
    else
      flash[:error] = 'Failed to delete the article'
      redirect_to @article
    end
  end

  private

  def article_params
    params.require(:article_form)
          .permit(:body, :title, :tags_string)
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
