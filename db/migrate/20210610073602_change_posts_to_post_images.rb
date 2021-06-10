class ChangePostsToPostImages < ActiveRecord::Migration[5.2]
  def change
    rename_table :posts, :post_images
  end
end
