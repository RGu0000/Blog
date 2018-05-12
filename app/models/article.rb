class Article < ApplicationRecord
  include ActiveModel::Validations
  belongs_to :author, class_name: 'User'
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
  validates :tags, presence: true
  validates_with ArticleBodyValidator
  accepts_nested_attributes_for :tags
  # validates :body, numericality: {greater_than_or_equal_to: 1, less_than_or_equal_to: 5}
  # validates :body, inclusion: { in: (1..5).to_a.map(&:to_s) }

  def tag_list
    tags.collect(&:name).join(', ')
  end
end
