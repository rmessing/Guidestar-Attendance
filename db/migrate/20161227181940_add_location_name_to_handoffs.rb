class AddLocationNameToHandoffs < ActiveRecord::Migration
  def change
  	add_column :handoffs, :location_name, :string
  end
end
