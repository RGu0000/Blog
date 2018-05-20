class RatingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article, only: %i[create edit update]

  def create
    @rating = @article.ratings.new(rating_params)
    if @rating.save
      flash[:notice] = 'Rating added'
    else
      flash[:danger] = 'Failed to add a rating'
    end
    redirect_to article_path(@article)
  end

  def update
    @rating = @article.ratings.where(author_id: current_user.id).first
    if @rating.update_attributes(rating_params)
      flash[:notice] = 'Rating updated'
      redirect_to article_path(@article)
    else
      flash[:danger] = 'Failed to add a rating'
    end
  end

  private

  def rating_params
    params.require(:rating)
          .permit(:rate)
          .merge(author_id: current_user.id)
  end

  def set_article
    @article = Article.find(params[:article_id])
  end
end
