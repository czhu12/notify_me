class AddUsernameAndUserPermalinkToAlerts < ActiveRecord::Migration[5.1]
  def change
    add_column :alerts, :username, :string
    add_column :alerts, :user_permalink, :string
  end
end
