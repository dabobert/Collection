class Book < ActiveRecord::Base
  
  has_one :item, :as=>:itemable

  def authors
    self.item.item_creators.find(:all, :conditions=>["creator_type_id = ?",CreatorType.find_by_name("author")])
  end
  
end
