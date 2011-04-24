class ItemMetadatum < ActiveRecord::Base
  belongs_to :item
  belongs_to :metadatum
end
