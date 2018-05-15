class UsersController < ApplicationController
  # before_action :set_user, only: %i[edit destroy]

  def index
    @users = User.all.paginate(page: params[:page], per_page: 25)
  end

  def show
    @user = User.find(params[:id]).decorate
  end

  def edit; end

  def update
    @user = User.new(user_params)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end

  def set_user
    @user = User.find(params[:id])
    # if user_signed_in? && current_user.id == @user.id
  end
end
