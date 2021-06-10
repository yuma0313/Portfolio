class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :name
      t.text :caption
      t.string :image_id
      t.string :address
      t.integer :prefecture

      t.timestamps
    end
  end
end
