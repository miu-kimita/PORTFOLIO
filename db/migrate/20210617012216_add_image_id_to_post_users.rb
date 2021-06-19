class AddImageIdToPostUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :post_users, :image_id, :string
  end
end
