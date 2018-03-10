class CreateSocialWatchers < ActiveRecord::Migration[5.1]
  def change
    create_table :social_watchers do |t|
      t.integer :listener_id
      t.integer :source
      t.integer :score
      t.text :metadata

      t.timestamps
    end

    add_index :social_watchers, :listener_id
  end
end
