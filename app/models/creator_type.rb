class CreatorType < SingleValueModel
  has_many :item_creators
  has_many :items, :through=>:item_creators
  has_many :creators, :through=>:item_creators
  belongs_to :item_type
end
