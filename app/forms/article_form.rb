class ArticleForm
  include ActiveModel::Model
  delegate :title, :body, :author_id, :tags, :id, :persisted?, :new_record?, to: :article
  attr_accessor :article, :tags_string
  validates :tags, presence: { error_message: "Tags can't be blank" }
  validates_length_of :title, within: 8..512
  validates_length_of :body, within: 8..2048
  # validates_length_of :tags_string, minimum: 1
  validate :validate_prohibited_words

  def self.model_name
    ActiveModel::Name.new(self, nil, 'Article')
  end

  def initialize(article = Article.new)
    @article = article
  end

  def save(article_params)
    assign_params_to_article(article_params)

    if valid?
      @article.tags.each(&:save!)
      @article.save!
      true
    else
      false
    end
  end

  def all_tags
    return tags.collect(&:name).join(', ') if tags.present?
    ''
  end

  private

  def assign_params_to_article(params)
    @article.attributes = params.except(:tags_string)
    @article.tags = tag_list(params[:tags_string])
  end

  def tag_list(tags_string)
    tags_string.scan(/\w+/)
               .map(&:downcase)
               .uniq
               .map { |name| Tag.find_or_initialize_by(name: name) }
  end

  def validate_prohibited_words
    forbidden_words = %w[noob n00b looser feeder newbie lame]
    errors.add(:body, 'contains prohibited word') if forbidden_words.any? { |word| @article.body.include?(word) }
    errors.add(:title, 'contains prohibited word') if forbidden_words.any? { |word| @article.title.include?(word) }
  end
end
