class UpdateBooksWithItems < ActiveRecord::Migration

  def self.up
    isbn=KeyType.find_by_name("isbn")
    Item.all.each do |item|
      Book.create :item=>item, :isbn=> item.keys.find(:first, :conditions=>["key_type_id=?",isbn.id]).value
    end
  end

  def self.down
    Book.all.each do |book|
      book.destroy
    end
  end
end
