class Metadatum < ActiveRecord::Base
  belongs_to :item
  belongs_to :metadata_type
end
