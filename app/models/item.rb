class Item < ActiveRecord::Base
  has_many :item_creators
  has_many :creators, :through=>:item_creators
  has_many :creator_types, :through=>:item_creators
  has_many :item_keys
  has_many :key_types, :through=>:item_keys
  has_many :metadata
  has_many :metadata_types, :through=>:metadata
  
  belongs_to :item_type
  default_scope :order=>:name
  
  attr_accessor :data
  accepts_nested_attributes_for :item_creators
  
  #validates_uniqueness_of :value, :scope => :user_id
 
  require 'amazon/aws'
  require 'amazon/aws/search'

  include Amazon::AWS
  include Amazon::AWS::Search
  
  def keys
    @keys ||= self.item_keys
  end
  
  def self.aws_lookup type, value
    type.upcase!
    if type =="ASIN"
      il = ItemLookup.new( type, { 'ItemId' => value,'MerchantId' => 'Amazon' })
    else
      il = ItemLookup.new( type, { 'ItemId' => value,'MerchantId' => 'Amazon',"SearchIndex"=>"All" })
    end
    rg = ResponseGroup.new( 'Medium' )

    req = Request.new(KEY_ID, ASSOCIATES_ID)
    puts req
  
    resp = req.search( il, rg)
    item = resp.item_lookup_response[0].items.item
  end
  
  
  def self.lookup type, value
    data = Item.aws_lookup type, value
    item = Item.new :name=>data.item_attributes.title.to_s,
                :publication_date =>data.item_attributes.publication_date.to_s,
                :image=>data.large_image.url.to_s,
                :item_type=>ItemType.construct(data.item_attributes.product_group.to_s.downcase),
                :year=>data.item_attributes.publication_date.to_s.to_date.year,
                :image_width=>data.large_image.width.to_s,
                :image_height=>data.large_image.height.to_s
    item.data = data
    case item.data.item_attributes.product_group.to_s.downcase
      when "book": item.assemble_book
      else "boo!"
    end
    item
  end
  
  def assemble_book 
    self.item_keys.build :value=>self.data.item_attributes.isbn.to_s, :key_type=>KeyType.construct("isbn")
    self.item_keys.build(:value=>self.data.item_attributes.asin.to_s, :key_type=>KeyType.construct("asin")) unless self.data.item_attributes.asin.blank?
    self.item_keys.build(:value=>self.data.item_attributes.ean.to_s,  :key_type=>KeyType.construct("ean"))  unless self.data.item_attributes.ean.blank?
    self.data.item_attributes.author.each do |author|
      self.item_creators.build :creator=>Creator.construct(author.to_s.downcase), :creator_type=>CreatorType.construct("author")
    end
    self.metadata.build :metadata_type=>MetadataType.construct("publisher"), :value=>self.data.item_attributes.publisher.to_s.downcase
    self.metadata.build :metadata_type=>MetadataType.construct("number_of_pages"), :value=>self.data.item_attributes.number_ofpages.to_s unless self.data.item_attributes.number_ofpages.blank?
    #self.metadata.build :metadata_type=>MetadataType.construct("dewey_decimal_number"), :value=>self.data.item_attributes.dewey_decimal_number.to_s unless self.data.item_attributes.dewey_decimal_number.blank?
    
  end
  
  
  
  def authors
    @authors ||= self.item_creators.find(:all, :conditions=>["creator_type_id = ?",CreatorType.find_by_name("author")]).collect do |item_creator| item_creator.creator end
  end
  
  
end
