class RemovePasswordFromParents < ActiveRecord::Migration
  def change
  	remove_column :parents, :password, :string
  end
end
