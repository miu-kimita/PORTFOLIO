class AddProfileImageIdToPostUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :post_users, :profile_image_id, :string
  end
end
