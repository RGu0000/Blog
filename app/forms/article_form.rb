class ArticleForm
  include ActiveModel::Model
  delegate :title, :body, :author_id, :tags, :id, :persisted?, :new_record?, to: :article
  attr_accessor :article
  validates_presence_of :title, :body, :tags
  validate :validate_prohibited_words

  def initialize(article)
    @article = article
  end

  def save(article_params)
    @article.update_attributes(article_params.slice('title', 'body', 'author_id'))
    @article.tags = tag_list(article_params[:tags_string])

    if valid?
      @article.save!
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

  private

  def validate_prohibited_words
    forbidden_words = %w[noob n00b looser feeder newbie lame]
    errors.add(:body, 'contains prohibited word') if forbidden_words.any? { |word| @article.body.include?(word) }
    errors.add(:title, 'contains prohibited word') if forbidden_words.any? { |word| @article.title.include?(word) }
  end
end
