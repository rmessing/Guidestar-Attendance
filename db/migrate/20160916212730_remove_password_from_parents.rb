class RemovePasswordFromParents < ActiveRecord::Migration
  def change
  	remove_column :parents, :password, :string
  	add_column :parents, :password_digest, :string
  end
end
