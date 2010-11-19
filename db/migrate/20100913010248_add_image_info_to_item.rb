class AddImageInfoToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :image, :string
    add_column :items, :image_width, :integer
    add_column :items, :image_height, :integer
  end

  def self.down
    remove_column :items, :image_height
    remove_column :items, :image_width
    remove_column :items, :image
  end
end
