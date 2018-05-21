class Rating < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :article

  validates_with RatingValidator
  validates_uniqueness_of :author_id, scope: :article_id
end
