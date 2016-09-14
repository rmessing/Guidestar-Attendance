class RemoveTeacherIdFromGroups < ActiveRecord::Migration
  def change
    remove_column :groups, :teacher_id, :integer
  end
end
