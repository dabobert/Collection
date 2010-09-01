class CreateItemCreators < ActiveRecord::Migration
  def self.up
    create_table :item_creators do |t|
      t.integer :item_id
      t.integer :creator_id
      t.integer :creator_type_id

      t.timestamps
    end
    add_index :item_creators, :item_id
    add_index :item_creators, :creator_id
    add_index :item_creators, :creator_type_id
  end

  def self.down
    drop_table :item_creators
  end
end
