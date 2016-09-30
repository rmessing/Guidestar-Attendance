class AddDirFnameToCenters < ActiveRecord::Migration
  def change
    add_column :centers, :dirfname, :string
  end
end
