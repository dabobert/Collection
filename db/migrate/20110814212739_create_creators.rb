class CreateCreators < ActiveRecord::Migration
  def self.up
    create_table :creators do |t|
      t.string :name

      t.timestamps
    end
    add_index :creators, :name
  end

  def self.down
    drop_table :creators
  end
end
