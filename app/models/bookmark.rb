class Bookmark < ApplicationRecord
  validates :user_id, presence: true
  validates :post_image_id, presence: true

  belongs_to :user
  belongs_to :post_image
end
