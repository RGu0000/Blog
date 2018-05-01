class Article < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :taggings
  has_many :tags, through: :taggings
  validates :title, presence: true
# validates :body, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5}
  #validates :body, inclusion: { in: (1..5).to_a.map(&:to_s) }

  def tag_list
    tags.collect(&:name).join(', ')
  end

  def tag_list=(tags_string)
    tag_names = tags_string.split(/\W+/).collect { |el| el.strip.downcase }.uniq
    new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name) }
    self.tags = new_or_found_tags
  end
end
