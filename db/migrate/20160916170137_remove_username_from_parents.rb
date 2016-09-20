class RemoveUsernameFromParents < ActiveRecord::Migration
  def change
    remove_column :parents, :username, :string
  end
end
