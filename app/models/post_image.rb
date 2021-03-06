class PostImage < ApplicationRecord
  belongs_to :user
  attachment :image

  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user # いいねランキング
  has_many :bookmarks, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def bookmarked_by?(user)
    bookmarks.where(user_id: user.id).exists?
  end

  #バリデーション
  validates :name, presence: true
  validates :caption, presence: true, length: { maximum: 200 }
  validates :address, presence: true
  validates :image, presence: true
  validates :rate, presence: true

  enum prefecture: {
    "都道府県を選択": 0,
    北海道: 1, 青森県: 2, 岩手県: 3, 宮城県: 4, 秋田県: 5, 山形県: 6, 福島県: 7,
    茨城県: 8, 栃木県: 9, 群馬県: 10, 埼玉県: 11, 千葉県: 12, 東京都: 13, 神奈川県: 14,
    新潟県: 15, 富山県: 16, 石川県: 17, 福井県: 18, 山梨県: 19, 長野県: 20,
    岐阜県: 21, 静岡県: 22, 愛知県: 23, 三重県: 24,
    滋賀県: 25, 京都府: 26, 大阪府: 27, 兵庫県: 28, 奈良県: 29, 和歌山県: 30,
    鳥取県: 31, 島根県: 32, 岡山県: 33, 広島県: 34, 山口県: 35,
    徳島県: 36, 香川県: 37, 愛媛県: 38, 高知県: 39,
    福岡県: 40, 佐賀県: 41, 長崎県: 42, 熊本県: 43, 大分県: 44, 宮崎県: 45, 鹿児島県: 46,
    沖縄県: 47,
  }

  # def enum_validation
  #   if f_params[:prefecture] == '都道府県を選択' # '都道府県を選択'のまま投稿できない
  #     flash[:danger] = '都道府県を選択してください'
  #     redirect_to post_images_path
  #   elsif !is_prefecture_valid # falseの場合
  #     flash[:danger] = '不正な操作です'
  #     redirect_to root_path
  #   elsif self.save
  #     flash[:success] = "投稿しました"
  #     redirect_to post_images_path
  #   else
  #     post_images = PostImage.all.page(params[:page]).per(4)
  #     render'index'
  #   end
  #   post_images
  # end

  def self.search(params)
    post_images = PostImage.all
    if params[:prefecture] && params[:prefecture] != '都道府県を選択' # 正しく都道府県を選択している必要がある
      post_images = where(prefecture: (params[:prefecture]).to_s)
    end
    if params[:keyword].present? # キーワード検索の場合
      keyword = params[:keyword]
      post_images = where(['address LIKE(?) OR name LIKE(?)', "%#{keyword}%", "%#{keyword}%"]) # 住所・カフェ名の検索
    end
    post_images
  end

  geocoded_by :address # 住所のカラム名
  after_validation :geocode, if: :address_changed? # address変更時に緯度・経度が更新される
end
