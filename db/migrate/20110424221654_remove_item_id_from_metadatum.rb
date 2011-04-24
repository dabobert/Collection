class RemoveItemIdFromMetadatum < ActiveRecord::Migration

  def self.up
    remove_column :metadata, :item_id
  end

  def self.down
    add_column :metadata, :item_id, :integer
  end

end
