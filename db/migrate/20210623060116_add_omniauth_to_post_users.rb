class AddOmniauthToPostUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :post_users, :provider, :string
    add_column :post_users, :uid, :string
  end
end
