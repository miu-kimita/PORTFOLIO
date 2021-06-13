class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :post_user_id
      t.integer :genre_id
      t.string :title
      t.string :image_id
      t.text :post_detail

      t.timestamps
    end
  end
end
