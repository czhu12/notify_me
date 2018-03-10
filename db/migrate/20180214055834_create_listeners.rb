class CreateListeners < ActiveRecord::Migration[5.1]
  def change
    create_table :listeners do |t|
      t.string :query
      t.string :token
      t.string :email
      t.string :phone_number

      t.integer :user_id
      t.timestamps
    end

    add_index :listeners, :token
  end
end
