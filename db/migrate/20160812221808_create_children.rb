class CreateChildren < ActiveRecord::Migration
  def change
    create_table :children do |t|
      t.string :fname
      t.string :mname
      t.string :lname
      t.integer :group_id
      t.integer :center_id

      t.timestamps null: false
    end
  end
end
