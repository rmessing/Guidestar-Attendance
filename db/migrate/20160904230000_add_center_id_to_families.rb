class AddCenterIdToFamilies < ActiveRecord::Migration
  def change
    add_column :families, :center_id, :integer
  end
end
