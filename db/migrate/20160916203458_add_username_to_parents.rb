class AddUsernameToParents < ActiveRecord::Migration
  def change
    add_column :parents, :username, :string
  end
end
