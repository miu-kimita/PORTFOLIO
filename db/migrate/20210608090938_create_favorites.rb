class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.integer :post_id
      t.integer :post_user_id
      t.string :post_image_id

      t.timestamps
    end
  end
end
