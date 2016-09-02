class AddActivationToCenters < ActiveRecord::Migration
  def change
    add_column :centers, :activation_digest, :string
    add_column :centers, :activated, :boolean, default: false
    add_column :centers, :activated_at, :datetime
  end
end
