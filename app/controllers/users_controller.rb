class UsersController < ApplicationController
  def index
    @users = User.all.paginate(page: params[:page], per_page: 25)
  end

  def show
    @user = User.find(params[:id]).decorate
  end
end
