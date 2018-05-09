class CommentsController < ApplicationController
  before_action :set_article, only: %i[create destroy]

  def create
    @comment = @article.comments.new(comment_params)
    @comments = @article.comments
    if @comment.save
      flash[:notice] = 'Comment added'
      redirect_to @article
    else
      # render :edit
      render 'articles/show', object: @comments
    end

    # respond_to do |format|
    #   if @comment.save
    #     format.html { redirect_to @article, notice: 'Comment was successfully created.' }
    #     format.js
    #     format.json { render json: @article, status: :created, location: @article }
    #   else
    #     format.html { render 'comments/_form', object: @comments }
    #     format.json { render json: @article.errors, status: :unprocessable_entity }
    #   end
    # end

  end

  def edit
    @article = Article.find(params[:id])
  end

  def destroy
    comment = @article.comments.find(params[:id])
    if comment.author_id == current_user.id && comment.destroy
      flash[:notice] = 'Comment successfully deleted!'
    else
      flash[:danger] = 'Failed to delete a comment. Try again.'
    end
    redirect_to @article
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
