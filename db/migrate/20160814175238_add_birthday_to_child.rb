class AddBirthdayToChild < ActiveRecord::Migration
  def change
  	add_column :children, :birthday, :datetime
  end
end
