class AddPasswordToParents < ActiveRecord::Migration
  def change
    add_column :parents, :password, :string
  end
end
