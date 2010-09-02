class Item < ActiveRecord::Base
  has_many :item_creators
  has_many :creators, :through=>:item_creators
  has_many :creator_types, :through=>:item_creators
  has_many :item_keys
  has_many :keys, :through=>:item_keys
  
  belongs_to :item_type
  default_scope :order=>:name
end
