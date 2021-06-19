class AddIntroductionToPostUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :post_users, :introduction, :text
  end
end
