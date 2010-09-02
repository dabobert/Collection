class ItemType < ActiveRecord::Base
  has_many :items
  default_scope :order => :name
end
