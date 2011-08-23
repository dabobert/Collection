class MetadataType < SingleValueModel
  has_many :metadata
  has_many :items, :through=>:metadata
end
