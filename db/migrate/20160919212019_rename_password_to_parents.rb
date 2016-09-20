class RenamePasswordToParents < ActiveRecord::Migration
  def change
  	rename_column :parents, :password, :password_digest
  end
end
