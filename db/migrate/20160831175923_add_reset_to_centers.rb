class AddResetToCenters < ActiveRecord::Migration
  def change
    add_column :centers, :reset_digest, :string
    add_column :centers, :reset_sent_at, :datetime
  end
end
