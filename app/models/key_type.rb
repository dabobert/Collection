class KeyType < SingleValueModel
  has_many :item_keys
  has_many :items, :through=>:item_keys
  
  default_scope :order=>:name
  
end