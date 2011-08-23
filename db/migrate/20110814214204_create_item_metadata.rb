class CreateItemMetadata < ActiveRecord::Migration
  def self.up
    create_table :item_metadata do |t|
      t.integer :item_id
      t.integer :metadatum_id

      t.timestamps
    end
    add_index :item_metadata, :item_id
    add_index :item_metadata, :metadatum_id
  end

  def self.down
    drop_table :item_metadata
  end
end
