class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :article

  validates :body, presence: true, length: { in: 8..256 }
end
