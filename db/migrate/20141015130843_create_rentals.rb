class CreateRentals < ActiveRecord::Migration
  def change
    create_table :rentals do |t|
      t.integer :user_id
      t.integer :book_id
      t.boolean :is_active
      t.timestamps
    end
  end
end
