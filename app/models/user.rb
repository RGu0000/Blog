class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable

  has_many :articles, foreign_key: 'author_id', dependent: :destroy
  validates :email, presence: true
end
