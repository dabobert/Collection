class AddPublicationDateToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :publication_date, :date
  end

  def self.down
    remove_column :items, :publication_date
  end
end
