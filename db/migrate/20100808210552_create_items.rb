class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :name
      t.float :rating
      t.integer :year
      t.integer :item_type_id
      t.string :location
      t.string :artwork
      t.timestamps
    end
    add_index :items, :name
    add_index :items, :item_type_id
    add_index :items, :year
    add_index :items, :rating
  end

  def self.down
    drop_table :items
  end
end
