class AddResetToParents < ActiveRecord::Migration
  def change
    add_column :parents, :reset_digest, :string
    add_column :parents, :reset_sent_at, :datetime
  end
end
