class RemoveBirthdayFromChildren < ActiveRecord::Migration
  def change
    remove_column :children, :birthday, :datetime
  end
end
