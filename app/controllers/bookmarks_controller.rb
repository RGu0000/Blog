class BookmarksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article

  def create
    if @article.bookmarks.create(bookmark_params)
      flash[:notice] = "Added bookmark on #{@article.title}."
    else
      flash[:danger] = 'Failed to add new bookmark.'
    end
    redirect_to @article
  end

  def destroy
    bookmark = @article.bookmarks.find(params[:id])
    if bookmark.user_id == current_user.id && bookmark.destroy
      flash[:notice] = 'Bookmark deleted'
    else
      flash[:danger] = 'Failed to delete bookmark'
    end
    redirect_to @article
  end

  private

  def bookmark_params
    params.permit(:article_id).merge(user_id: current_user.id)
  end

  def set_article
    @article = Article.find(params[:article_id])
  end
end
