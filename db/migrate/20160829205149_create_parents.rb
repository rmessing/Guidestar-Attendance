class CreateParents < ActiveRecord::Migration
  def change
    create_table :parents do |t|
      t.string :fname
      t.string :lname
      t.string :email
      t.string :username
      t.string :password_digest
      t.integer :center_id

      t.timestamps null: false
    end
  end
end
