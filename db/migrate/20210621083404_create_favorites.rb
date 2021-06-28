class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites, id: :integer do |t|
      t.integer :post_user_id
      t.integer :post_id

      t.timestamps
    end
  end
end
