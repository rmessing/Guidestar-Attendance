class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.integer :teacher_id
      t.integer :center_id

      t.timestamps null: false
    end
  end
end
