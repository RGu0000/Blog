class ArticleForm
  include ActiveModel::Model
  delegate :title, :body, :author_id, :tags, to: :article
  attr_accessor :article, :tags_string
  validates_presence_of :body

  def initialize
    @article ||= Article.new
  end

  def save(params)
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
    tags_string.scan(/\w+/)
               .map(&:downcase)
               .uniq
               .map { |name| Tag.find_or_create_by(name: name) }
  end

  def all_tags
    return tags.collect(&:name).join(', ') if tags.present?
    ''
  end
end
