class TagsController < ApplicationController
  require 'will_paginate/array'

  def index
    @tags = TagsQuery.sort_by_occurances
                     .paginate(page: params[:page], per_page: 25)
  end

  def show_name
    @tag = Tag.find_by(name: params[:name])
  end
end
