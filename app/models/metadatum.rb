class Metadatum < ActiveRecord::Base
  has_many :item_metadata
  has_many :items, :through=>:item_metadata
  belongs_to :metadata_type
  
  
  def self.construct(type, value)
    type = MetadataType.construct(type)
    self.find(:first, :conditions=>["metadata_type_id=? and value=?",type.id,value]) || self.create(:metadata_type=>type, :value=>value)
  end
end