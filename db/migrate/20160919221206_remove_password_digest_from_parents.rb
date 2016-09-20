class RemovePasswordDigestFromParents < ActiveRecord::Migration
  def change
    remove_column :parents, :password_digest, :string
  end
end
