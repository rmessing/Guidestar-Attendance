class CreateHandoffs < ActiveRecord::Migration
  def change
    create_table :handoffs do |t|
      t.string :attend
      t.integer :child_id
      t.string :child_fname
      t.string :child_mname
      t.string :child_lname
      t.integer :center_id
      t.string :escort_fname
      t.string :escort_lname
      t.string :group_name

      t.timestamps null: false
    end
  end
end
