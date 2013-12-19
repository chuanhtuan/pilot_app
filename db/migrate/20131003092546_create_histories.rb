class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.string :content
      t.integer :poster_id
      t.integer :receiver_id

      t.timestamps
    end
    add_index :histories, [:created_at]
  end
end
