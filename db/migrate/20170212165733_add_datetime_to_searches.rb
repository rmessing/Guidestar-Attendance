class AddDatetimeToSearches < ActiveRecord::Migration
  def change
  	add_column :searches, :date_from, :datetime
  	add_column :searches, :date_to, :datetime
  end
end
