class ItemCreator < ActiveRecord::Base
  belongs_to :item
  belongs_to :creator
  belongs_to :creator_type
  
  accepts_nested_attributes_for :creator
  accepts_nested_attributes_for :creator_type
end
