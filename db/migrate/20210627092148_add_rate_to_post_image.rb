class AddRateToPostImage < ActiveRecord::Migration[5.2]
  def change
    add_column :post_images, :rate, :float
  end
end
