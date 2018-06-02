class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_article, only: %i[edit update destroy]
  before_action :set_new_article_form, only: %i[new create]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 25)
  end

  def show
    @article = Article.includes(:author).find(params[:id]).decorate
    initialize_associated_objects
  end

  def new; end

  def create
    if @article_form.save(article_params)
      flash[:notice] = 'You have added a new article.'
      redirect_to @article_form.article
    else
      flash.now[:error] = 'Failed to add a new article. Check errors below.'
      render :new
    end
  end

  def edit; end

  def update
    if @article_form.save(article_params)
      flash[:success] = 'Article updated'
      TagServices::OrphanTagDestroyer.call
      redirect_to @article_form.article
    else
      flash.now[:error] = 'Failed to update the article. Check errors below.'
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
    params.require(:article)
          .permit(:body, :title, :tags_string)
          .merge(author_id: current_user.id)
  end

  def set_new_article_form
    @article_form = ArticleForm.new
  end

  def set_article
    @article = Article.find(params[:id])
    @article_form = ArticleForm.new(@article)
    authorize @article, :authorized?
  end

  def initialize_associated_objects
    @comments = Comment.includes(:author, :children, :article).where(article_id: @article.id).hash_tree
    @comment = Comment.new
    @rating = @article.ratings.find_by(author_id: current_user) || @article.ratings.new
    @average_rating = Rating.where(article_id: @article).average(:rate) || 0.0
    @vote_count = Rating.where(article_id: @article).count
    @user_bookmark = @article.bookmarks.where(user_id: current_user).first if current_user.present?
  end
end
