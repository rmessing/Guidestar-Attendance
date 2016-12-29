class RemoveLocationNameFromSearches < ActiveRecord::Migration
  def change
  	remove_column :searches, :location_name, :string
  end
end
