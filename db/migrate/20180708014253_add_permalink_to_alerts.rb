class AddPermalinkToAlerts < ActiveRecord::Migration[5.1]
  def change
    add_column :alerts, :permalink, :string
  end
end
