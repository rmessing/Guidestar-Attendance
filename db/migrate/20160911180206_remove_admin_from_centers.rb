class RemoveAdminFromCenters < ActiveRecord::Migration
  def change
  	remove_column :centers, :admin, :boolean
  end
end
