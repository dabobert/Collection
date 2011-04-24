class MakeItemPolymorphic < ActiveRecord::Migration
  def self.up
    add_column :items, :itemable_type, :string
    add_column :items, :itemable_id, :integer
    add_index :items, :itemable_id
  end

  def self.down
    remove_column :items, :itemable_type
    remove_column :items, :itemable_id
  end
end
