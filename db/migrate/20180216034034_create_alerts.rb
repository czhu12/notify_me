class CreateAlerts < ActiveRecord::Migration[5.1]
  def change
    create_table :alerts do |t|
      t.integer :social_watcher_id
      t.string :data_id
      t.text :text
      t.text :data

      t.timestamps
    end
    add_index :alerts, :social_watcher_id
    add_index :alerts, :data_id
  end
end
