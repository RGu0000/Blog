class ArticleForm
  include ActiveModel::Model
  delegate :title, :body, :author_id, :tags, :tags_string, to: :article
  attr_accessor :article

  def article
    @article ||= Article.new
  end

  def submit(params)
    article.attributes = params.slice('title', 'body', 'author_id')
    article.tags = tag_list(params[:tags_string])

    if valid?
      article.save!
      true
    else
      false
    end
  end

  def tag_list(tags_string)
    tags_string.split(/\W/)
               .map(&:downcase)
               .uniq
               .map { |name| Tag.find_or_create_by(name: name) }
  end

  def all_tags
    return tags.collect(&:name).join(', ') if tags.present?
    ''
  end



end
