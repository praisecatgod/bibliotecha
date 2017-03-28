class CreateBookGenre < ActiveRecord::Migration
  def change
    create_table :book_genre do |t|
      t.integer :book_id
      t.integer :genre_id
      t.timestamps
    end
  end
end
