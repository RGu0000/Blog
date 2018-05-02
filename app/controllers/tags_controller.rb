class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id])
  end

  def show_name
    @tag = Tag.find_by(name: params[:name])
  end

  def index
    @tags = Tag.all
  end
end
