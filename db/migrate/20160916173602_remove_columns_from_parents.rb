class RemoveColumnsFromParents < ActiveRecord::Migration
  def change
    remove_column :parents, :reset_digest, :string
    remove_column :parents, :reset_sent_at, :datetime
  end
end
