class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable

  has_many :articles, foreign_key: 'author_id'
  has_many :comments, foreign_key: 'author_id'
  validates :email, presence: true
end
