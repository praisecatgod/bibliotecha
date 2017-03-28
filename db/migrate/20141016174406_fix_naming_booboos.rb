class FixNamingBooboos < ActiveRecord::Migration
  def change
      rename_table :book_author, :book_authors
      rename_table :book_genre, :book_genres
      rename_column :books, :name, :title
  end
end
