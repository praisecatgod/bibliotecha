class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.integer :isbn
      t.string :title
      t.text :summary
      t.timestamps
    end

  end
end
