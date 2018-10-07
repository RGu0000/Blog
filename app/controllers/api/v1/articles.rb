module API
  module V1
    class Articles < Grape::API
      include API::V1::Defaults

      resource :articles do
        desc 'Return all articles'
        get '', root: :articles do
          Article.all.includes(:tags)
        end

        desc 'Return a article'
        params do
          requires :id, type: Integer, desc: 'ID of the
            article'
        end
        get ':id', root: 'article' do
          Article.where(id: permitted_params[:id]).first!
        end

        desc 'Creates an article'
        params do
          requires :author_id, type: Integer, desc: 'Id of the author'
          requires :title, type: String, desc: 'Title of the article'
          requires :body, type: String, desc: 'Body of the article'
          requires :tag_id, type: Integer, desc: 'Tag'
        end
        post do
          article = Article.new(
            author_id: params[:author_id],
            title: params[:title],
            body: params[:body],
          )
          article.tags << Tag.find(params[:tag_id])
          article.save!
        end
      end
    end
  end
end
