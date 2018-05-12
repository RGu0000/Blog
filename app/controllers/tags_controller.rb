class TagsController < ApplicationController
  require 'will_paginate/array'

  def show
    @tag = Tag.find(params[:id])
  end

  def show_name
    @tag = Tag.find_by(name: params[:name])
  end

  def index
    @tags = Tag.all
               .sort { |a, b| b.articles.count <=> a.articles.count }
               .paginate(page: params[:page], per_page: 25)
  end
end
