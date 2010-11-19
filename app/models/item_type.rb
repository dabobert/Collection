class ItemType < SingleValueModel
  has_many :items
  default_scope :order => :name
end
