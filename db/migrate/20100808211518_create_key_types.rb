class CreateKeyTypes < ActiveRecord::Migration
  def self.up
    create_table :key_types do |t|
      t.string :name
      t.integer :item_type_id

      t.timestamps
    end
    add_index :key_types, :item_type_id
  end

  def self.down
    drop_table :key_types
  end
end
