class Tag < ApplicationRecord
  has_many :taggings
  has_many :articles, through: :taggings
  validates :name, presence: true, uniqueness: true

  def to_s
    name
  end
end
