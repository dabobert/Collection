class CreateItemKeys < ActiveRecord::Migration
  def self.up
    create_table :item_keys do |t|
      t.integer :item_id
      t.integer :key_id

      t.timestamps
    end
    add_index :item_keys, :item_id
    add_index :item_keys, :key_id
  end

  def self.down
    drop_table :item_keys
  end
end
