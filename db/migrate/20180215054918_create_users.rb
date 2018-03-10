class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.boolean :guest
      t.string :email
      t.string :password_hash
      t.string :password_salt
      t.string :email
      t.string :phone_number

      t.timestamps
    end
  end
end
