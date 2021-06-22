class AddSubjectToContacts < ActiveRecord::Migration[5.2]
  def change
    add_column :contacts, :subject, :integer
  end
end
