class CreatePostComments < ActiveRecord::Migration[5.2]
  def change
    create_table :post_comments do |t|
      t.integer :post_user_id
      t.string :post_image_id

      t.timestamps
    end
  end
end
