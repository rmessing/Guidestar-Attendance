class AddLocationToChild < ActiveRecord::Migration
  def change
  	add_column :children, :location_id, :integer
  end
end
