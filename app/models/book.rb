class Book < Item
  
  attr_accessor :item
  
  def self.find(id)
    item = Item.find(id)
    self
  end
  
  def authors
    self.item_creators.find(:all, :conditions=>["creator_type_id = ?",CreatorType.find_by_name("author")])
  end
end
