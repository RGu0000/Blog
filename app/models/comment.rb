class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :article
  belongs_to :parent, class_name: 'Comment', optional: true
  has_many :children, class_name: 'Comment', foreign_key: 'parent_id'

  validates :body, presence: true, length: { in: 8..256 }
end
