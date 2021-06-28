class RenameNameColumnToGenres < ActiveRecord::Migration[5.2]
  def change
    rename_column :genres, :name, :genre_name
  end
end
