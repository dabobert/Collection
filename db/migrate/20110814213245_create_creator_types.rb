class CreateCreatorTypes < ActiveRecord::Migration
  def self.up
    create_table :creator_types do |t|
      t.string :name
      t.integer :item_type_id

      t.timestamps
    end
    add_index :creator_types, :item_type_id
  end

  def self.down
    drop_table :creator_types
  end
end
