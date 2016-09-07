class AddBirthdateToChildren < ActiveRecord::Migration
  def change
    add_column :children, :birth_date, :datetime
  end
end
