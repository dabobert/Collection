class ItemKey < ActiveRecord::Base
  belongs_to :item
  belongs_to :key_type
  
  validates_presence_of :value
end
