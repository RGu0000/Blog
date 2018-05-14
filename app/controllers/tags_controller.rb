class TagsController < ApplicationController
  require 'will_paginate/array'

  def show
    @tag = Tag.find(params[:id])
  end

  def show_name
    @tag = Tag.find_by(name: params[:name])
  end

  def index
  # @tags = Tagging.joins(:tag).select('tags.name, COUNT(tag.id) AS tags_count').group('tag.id')
               # .paginate(page: params[:page], per_page: 25)
  @tags = Tagging.all.joins(:tag).select('tags.name, COUNT(taggings.id) AS tags_count').group('tags.id').order('tags_count desc').paginate(page: params[:page], per_page: 25)

  # Tagging.joins(:tag).select('tags.name, COUNT(tag.id) AS tags_count').group('tag.id')
  end
end
