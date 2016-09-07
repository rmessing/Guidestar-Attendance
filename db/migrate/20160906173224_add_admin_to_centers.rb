class AddAdminToCenters < ActiveRecord::Migration
  def change
    add_column :centers, :admin, :boolean, default: false
  end
end
