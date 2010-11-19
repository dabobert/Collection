class FixItemKeyModel < ActiveRecord::Migration
  def self.up
    add_column :item_keys, :value, :string
    rename_column :item_keys, :key_id, :key_type_id
  end

  def self.down
    remove_column :item_keys, :value
    rename_column :item_keys, :key_type_id, :key_id
  end
end
