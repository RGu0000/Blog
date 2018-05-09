class CommentsController < ApplicationController
  before_action :set_article, only: %i[create]

  def create
    @comment = @article.comments.new(comment_params)
    if @comment.save
      flash[:notice] = 'Comment added'
      redirect_to @article
    else
      render 'articles/show'
    end
  end

  def index
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end

  def comment_params
    params.require(:comment)
          .permit(:body)
          .merge(author_id: current_user.id)
  end
end
