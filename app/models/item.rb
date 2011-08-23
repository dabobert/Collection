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
  
  belongs_to :itemable, :polymorphic=>true, :autosave=>true, :dependent => :destroy, :touch=>true
  belongs_to :item_type
  default_scope :order=>:name
  
  accepts_nested_attributes_for :item_creators
  
  attr_accessor :data, :type
  
  
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
  
  
  
  def self.lookup(attr)
    if attr.class == "Hash"
      key_str = attr[:value]
    elsif attr.class == String
      key_str = attr
    else
      raise "Item::lookup what are you try to pull by passing me a #{attr.class.name}"
    end
    
    key = ItemKey.find_by_value(key_str)
    if key.blank?
      data  = ItemLookup.find(key_str)
      type  = data.find_value("ProductGroup").downcase

      large_image = data.find_value("LargeImage")
      small_image = data.find_value("SmallImage")

      item = Item.new :name=>data.clean_title,
                  :publication_date => data.find_value("PublicationDate"),
                  :image => large_image["URL"],
                  :image_width => large_image["Width"]["__content__"],
                  :image_height => large_image["Height"]["__content__"],
                  :thumbnail => small_image["URL"],
                  :thumbnail_width => small_image["Width"]["__content__"],
                  :thumbnail_height => small_image["Height"]["__content__"]
      item.year = item.publication_date unless item.publication_date.blank? #needs to be optional value
      item.data = data
      item.item_keys.build(:value=>data.xml.xpath("//xmlns:Item/xmlns:ASIN")[0].text, :key_type=>KeyType.construct("asin"))
      case type
        when "book": item.assemble_book
      end
      item
    else
      item = key.item
    end
  end
  
  
  
  
  def assemble_book
    self.itemable       = Book.new
    self.itemable.isbn  = self.data.find_value("ISBN")
    unless self.data.xml.xpath('//xmlns:EditorialReview[xmlns:Source="Product Description"]/xmlns:Content').blank?
      self.build_summary
      self.summary.text = self.data.xml.xpath('//xmlns:EditorialReview[xmlns:Source="Product Description"]/xmlns:Content')[0].text
    end
    self.item_keys.build(:value=>self.data.find_value("ISBN"), :key_type=>KeyType.construct("isbn"))
    self.item_keys.build(:value=>self.data.find_value("EAN"),  :key_type=>KeyType.construct("ean"))  unless self.data.find_value("EAN").blank?
    self.item_keys.build(:value=>self.data.find_value("SKU"),  :key_type=>KeyType.construct("sku"))  unless self.data.find_value("SKU").blank?
    
    self.data.find_value("Author").each do |author|
      self.item_creators.build :creator=>Creator.construct(author.to_s), :creator_type=>CreatorType.construct("author")
    end unless self.data.find_value("Author").blank?

    self.data.xml.xpath("//xmlns:ItemAttributes/xmlns:Creator").each do |node|
      self.item_creators.build :creator=>Creator.construct(node.text),
                               :creator_type=>CreatorType.construct(node.attributes["Role"].text)
    end

    self.item_metadata.build :metadatum=>Metadatum.construct("publisher", self.data.find_value("Publisher"))
    self.item_metadata.build :metadatum=>Metadatum.construct("number_of_pages", self.data.find_value("NumberOfPages")) unless self.data.find_value("NumberOfPages").blank?

    self.pruned_categories.each do |category|
      self.item_metadata.build :metadatum=>Metadatum.construct("category", category)
    end
  
  end  
  
  protected
  

  
  def pruned_categories
    @pruned_categories ||= (
      categories = self.data.xml.xpath("//xmlns:BrowseNode/xmlns:Name").collect do |node|
        node.text
      end.uniq
      
      ["Subjects","Subject","Publishers"].each do |category|
        categories.delete(category)
      end
      @pruned_categories = categories
    )
  end
  
end
