class AddUsernameToCenters < ActiveRecord::Migration
  def change
    add_column :centers, :username, :string
  end
end
