class WhyAmSoDumb < ActiveRecord::Migration
  def change
    rename_column :book_authors, :genre_id, :author_id
  end
end
