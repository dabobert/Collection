class Creator < ActiveRecord::Base
  has_many :item_creators
  has_many :items, :through=>:item_creators

  default_scope :order=>:name
end
