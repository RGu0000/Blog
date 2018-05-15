class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article, only: %i[new create destroy]

  def new
    @comment = @article.comments.new(parent_id: params[:parent_id])
  end

  def create
    @comment = @article.comments.new(comment_params)
    @comments = @article.comments.includes(:author, :children).hash_tree

    if @comment.save
      flash[:notice] = 'Comment added'
      redirect_to article_path(@article)
    else
      render 'articles/show', object: @comments
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def destroy
    comment = Comment.find(params[:id])

    if comment.author_id == current_user.id && comment.destroy
      flash[:notice] = 'Comment successfully deleted!'
    else
      flash[:danger] = 'Failed to delete a comment. Try again.'
    end

    redirect_to @article
  end

  private

  def set_article
    @article = Article.find(params[:article_id]).decorate
  end

  def comment_params
    params.require(:comment)
          .permit(:body, :parent_id)
          .merge(author_id: current_user.id)
  end
end
