class RemoveLocationfromChild < ActiveRecord::Migration
  def change
  	remove_column :children, :location_id, :integer
  end
end
