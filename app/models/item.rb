class Item < ActiveRecord::Base
  has_many :item_creators, :dependent=>:destroy
  has_many :creators, :through=>:item_creators
  has_many :creator_types, :through=>:item_creators
  has_many :item_keys, :dependent=>:destroy
  has_many :key_types, :through=>:item_keys
  has_many :item_metadata, :dependent=>:destroy
  has_many :metadata, :through=>:item_metadata
  has_many :metadata_types, :through=>:metadata
  
  has_one :summary, :class_name=>'FullText', :as=>'textable', :dependent=>:destroy
  
  belongs_to :itemable, :polymorphic=>true
  belongs_to :item_type
  default_scope :order=>:name
  
  attr_accessor :data, :req, :resp
  accepts_nested_attributes_for :item_creators
  
  #validates_uniqueness_of :value, :scope => :user_id
 
  require 'amazon/aws'
  require 'amazon/aws/search'

  include Amazon::AWS
  include Amazon::AWS::Search
  
  def keys
    @keys ||= self.item_keys
  end
  
  
  def role(creator)
    self.item_creators.find(:first, :conditions=>["creator_id=?",creator]).creator_type.name
  end
  
  
  def metadata_types
    self.metadata.collect do |metadatum|
      metadatum.metadata_type
    end
  end
  
  
  #AWS Function & AWS Suport Functions=====================================
  def self.aws_lookup type, value
    type.upcase!
    if type =="ASIN"
      il = ItemLookup.new( type, { 'ItemId' => value,'MerchantId' => 'Amazon' })
    else
      il = ItemLookup.new( type, { 'ItemId' => value,'MerchantId' => 'Amazon',"SearchIndex"=>"All" })
    end
    rg = ResponseGroup.new( 'Large' )

    @req = Request.new(KEY_ID, ASSOCIATES_ID, "US")
    puts rg.inspect
    puts @req.inspect
    puts ""
    @resp = @req.search( il, rg)
    item = @resp.item_lookup_response[0].items.item
  end
  
  
  def self.lookup type, value
    key = ItemKey.find_by_value(value)
    if key.blank?
      data = Item.aws_lookup type, value
      item = Item.new :name=>Item.clean_book_title(data.item_attributes.title.to_s),
                  :publication_date =>data.item_attributes.publication_date.to_s,
                  :item_type=>ItemType.construct(data.item_attributes.product_group.to_s.downcase),
                  :year=>data.item_attributes.publication_date.to_s.to_date.year,
                  :image=>data.large_image.url.to_s,
                  :image_width=>data.large_image.width.to_s,
                  :image_height=>data.large_image.height.to_s,
                  :thumbnail=>data.small_image.url.to_s,
                  :thumbnail_height=>data.small_image.height.to_s,
                  :thumbnail_width=>data.small_image.width.to_s
      item.resp = @resp
      item.req  = @req            
      item.data = data
      item.item_keys.build(:value=>item.data.asin.to_s, :key_type=>KeyType.construct("asin"))
      case item.data.item_attributes.product_group.to_s.downcase
        when "book": item.assemble_book
        else "boo!"
      end
    else
      item = key.item
    end
    item
  end
  
  def assemble_book
    self.itemable       = Book.new
    self.itemable.isbn  = self.data.item_attributes.isbn.to_s
    unless self.data.editorial_reviews.blank?
      self.build_summary
      self.summary.text = self.data.editorial_reviews.editorial_review.content.to_s.strip_tags
    end
    self.item_keys.build :value=>self.data.item_attributes.isbn.to_s, :key_type=>KeyType.construct("isbn")  
    self.item_keys.build(:value=>self.data.item_attributes.ean.to_s,  :key_type=>KeyType.construct("ean"))  unless self.data.item_attributes.ean.blank?
    
    self.data.item_attributes.author.each do |author|
      self.item_creators.build :creator=>Creator.construct(author.to_s), :creator_type=>CreatorType.construct("author")
    end

    self.data.item_attributes.creator.each do |temp_creator|
      self.item_creators.build :creator=>Creator.construct(temp_creator.to_s), :creator_type=>CreatorType.construct(temp_creator.attrib["role"].downcase)
    end unless self.data.item_attributes.creator.blank?

    self.item_metadata.build :metadatum=>Metadatum.construct("publisher", self.data.item_attributes.publisher.to_s.downcase)
    self.item_metadata.build :metadatum=>Metadatum.construct("number_of_pages", self.data.item_attributes.number_ofpages.to_s) unless self.data.item_attributes.number_ofpages.blank?
    self.item_metadata.build :metadatum=>Metadatum.construct("category", self.data.browse_nodes[0].browse_node[0].to_h.values[0].to_s)
    self.item_metadata.build :metadatum=>Metadatum.construct("category",self.data.browse_nodes[0].browse_node[0].to_h.values[1].browse_node[0].name[0].to_s)
  end
  
  
  def self.foo
    Item.find(:all, :order=>:id)
  end
  
  def self.clean_book_title str
    str.gsub("Volume", "Vol.").gsub(", Vol", " Vol").gsub("Vol ", "Vol. ").gsub(/Vol. (([1-9])[^0-9]|([1-9])$)/, 'Vol. 0\1')
  end
  
  private
  
  def before_destroy
    self.itemable.destroy unless self.itemable.destroy
  end
  
  def before_save
    self.itemable.save!
  end
  
end
