class ItemType < SingleValueModel
  has_many :items
  default_scope :order => :name
  
  def self.construct name
    ItemType.find_by_name(name) || ItemType.create(:name=>name)
  end
end