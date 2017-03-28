class CreateBookAuthor < ActiveRecord::Migration
  def change
    create_table :book_author do |t|
      t.integer :author_id
      t.integer :book_id
      t.timestamps
    end
  end
end
