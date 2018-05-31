class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable,
        :omniauthable, omniauth_providers: %i[google_oauth2 facebook]

  has_many :articles, foreign_key: 'author_id', dependent: :destroy
  has_many :comments, foreign_key: 'author_id', dependent: :destroy
  has_many :ratings, foreign_key: 'author_id', dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  mount_uploader :avatar, AvatarUploader

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    unless user
      password = Devise.friendly_token[0, 20]
      user = User.new(
        name: data['name'],
        email: data['email'],
        password: password,
        password_confirmation: password,
        remote_avatar_url: data['image']
      )
      user.email ||= "#{user.name.gsub(/\s+/, '')}@facebook.com"
      user.save
    end
    user
  end
end
