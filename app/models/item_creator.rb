class ItemCreator < ActiveRecord::Base
  belongs_to :item
  belongs_to :creator
  belongs_to :creator_type
end
