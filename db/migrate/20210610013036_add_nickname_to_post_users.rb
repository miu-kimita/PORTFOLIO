class AddNicknameToPostUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :post_users, :nickname, :string
  end
end
