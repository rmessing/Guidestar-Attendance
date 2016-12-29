class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :keywords
      t.string :class_name
      t.string :child_name
      t.string :adult_name
      t.string :location_name

      t.timestamps null: false
    end
  end
end
