class CreateGroupTeachers < ActiveRecord::Migration
  def change
    create_table :group_teachers do |t|
      t.integer :teacher_id
      t.integer :group_id
      t.integer :center_id

      t.timestamps null: false
    end
  end
end
