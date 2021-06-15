class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :post_images, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_post_images, through: :favorites, source: :post_image #ユーザーがいいねした投稿を表示
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_post_images, through: :bookmarks, source: :post_image #ユーザーがブックマークした投稿を表示
  has_many :events, dependent: :destroy
  
  devise :omniauthable, omniauth_providers: %i[facebook twitter google_oauth2]
  # omniauthのコールバック時に呼ばれるメソッド
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end
end