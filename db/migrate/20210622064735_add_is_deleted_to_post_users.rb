class AddIsDeletedToPostUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :post_users, :is_deleted, :boolean, default: false, null: false
  end
end
