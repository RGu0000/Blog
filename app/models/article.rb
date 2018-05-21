class Article < ApplicationRecord
  include ActiveModel::Validations
  belongs_to :author, class_name: 'User'
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
end
