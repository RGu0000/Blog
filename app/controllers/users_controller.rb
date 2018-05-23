class UsersController < ApplicationController
  def index
    @users = User.all.paginate(page: params[:page], per_page: 25)
  end

  def show
    @user = User.find(params[:id]).decorate
    @bookmarked_articles = Bookmark.includes(:article).where(user_id: @user.id)
    @user_rates = Rating.includes(:article).where(author_id: @user.id)
  end
end
