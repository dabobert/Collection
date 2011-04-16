class AddThumbnailInfoToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :thumbnail, :text
    add_column :items, :thumbnail_height, :integer
    add_column :items, :thumbnail_width, :integer
  end

  def self.down
    remove_column :items, :thumbnail_width
    remove_column :items, :thumbnail_height
    remove_column :items, :thumbnail
  end
end
