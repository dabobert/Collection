class ItemKey < ActiveRecord::Base
  belongs_to :item
  belongs_to :key_type
end
