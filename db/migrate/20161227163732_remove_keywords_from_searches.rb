class RemoveKeywordsFromSearches < ActiveRecord::Migration
  def change
  	remove_column :searches, :keywords, :string
  end
end
