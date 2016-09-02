class RemoveActivationToCenters < ActiveRecord::Migration
  def change
    remove_column :centers, :activation_digest, :string
    remove_column :centers, :activated, :boolean
    remove_column :centers, :activated_at, :datetime
  end
end
