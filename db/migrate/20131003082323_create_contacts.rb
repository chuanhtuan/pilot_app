class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :contact_id
      t.integer :contacted_id

      t.timestamps
    end
    add_index :contacts, :contact_id
    add_index :contacts, :contacted_id
    add_index :contacts, [:contact_id, :contacted_id], unique: true
  end
end
