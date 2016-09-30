class AddDirlnameToCenters < ActiveRecord::Migration
  def change
    add_column :centers, :dirlname, :string
  end
end
