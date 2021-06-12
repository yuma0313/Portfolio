class ChangeColumnPrefectureToPostImages < ActiveRecord::Migration[5.2]
  def change
    change_column :post_images, :prefecture, :integer
  end
end
