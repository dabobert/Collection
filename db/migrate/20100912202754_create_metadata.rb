class CreateMetadata < ActiveRecord::Migration
  def self.up
    create_table :metadata do |t|
      t.integer :item_id
      t.integer :metadata_type_id
      t.string :value

      t.timestamps
    end
  end

  def self.down
    drop_table :metadata
  end
end
