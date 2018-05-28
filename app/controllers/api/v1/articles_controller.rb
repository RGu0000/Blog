module Api
  module V1
    class ArticlesController < ApplicationController
      def index
        render json: Article.all, include: { tags: { only: :name } }, only: %i[id title body tags]
      end

      def show
        render json: Article.find(params[:id])
      end
    end
  end
end
