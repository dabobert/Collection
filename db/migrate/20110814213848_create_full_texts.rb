class CreateFullTexts < ActiveRecord::Migration
  def self.up
    create_table :full_texts do |t|
      t.text :text
      t.integer :textable_id
      t.string :textable_type

      t.timestamps
    end
  end

  def self.down
    drop_table :full_texts
  end
end
