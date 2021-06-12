class ChangeDataPrefectureToPostImages < ActiveRecord::Migration[5.2]
  def change
    change_column :post_images, :prefecture, :string
  end
end
