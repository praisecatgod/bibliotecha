class CreateUsers < ActiveRecord::Migration
  def change

    create_table :users do |t|
      t.string :email
      t.integer :library_card
      t.boolean :is_admin
      t.boolean :confirmed
      t.string :confirmation_code
      t.string :password_digest
      t.timestamps
    end

  end
end
