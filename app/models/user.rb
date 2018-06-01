class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable,
        :omniauthable, omniauth_providers: %i[google_oauth2 facebook]

  has_many :articles, foreign_key: 'author_id', dependent: :destroy
  has_many :comments, foreign_key: 'author_id', dependent: :destroy
  has_many :ratings, foreign_key: 'author_id', dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  mount_uploader :avatar, AvatarUploader

  def self.new_with_session(params, session)
    super.tap do |user|
      if (data = session['devise.facebook_data'] && session['devise.facebook_data']['extra']['raw_info'])
        user.email = data['email'] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.first_name
      user.remote_avatar_url = auth.info.image.gsub('http://', 'https://')
    end
  end
end
