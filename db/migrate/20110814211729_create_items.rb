class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :name
      t.float :rating
      t.integer :year
      t.integer :item_type_id
      t.string :location
      t.string :artwork
      t.date :publication_date
      t.string :image
      t.string :image_width
      t.string :image_height
      t.string :thumbnail
      t.integer :thumbnail_height
      t.integer :thumbnail_width
      t.string :itemable_type, :string
      t.integer :itemable_id, :integer
      t.timestamps
    end
    add_index :items, :name
    add_index :items, :item_type_id
    add_index :items, :year
    add_index :items, :rating
    add_index :items, :itemable_id
  end

  def self.down
    drop_table :items
  end
end
