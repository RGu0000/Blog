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
    unless (email = data['email'])
      email = "#{data['name'].gsub(/\s+/, '').downcase}@facebook.com"
    end
    user = User.where(email: email).first

    unless user
      password = Devise.friendly_token[0, 20]
      user = User.create(
        name: data['name'],
        email: email,
        password: password,
        password_confirmation: password,
        remote_avatar_url: data['image']
      )
    end
    user
  end
end
