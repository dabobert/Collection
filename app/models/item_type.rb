class ItemType < ActiveRecord::Base
  default_scope :order => :name
end
