class Debug
  
  
  
  
  
  require 'amazon/aws'
  require 'amazon/aws/search'

  include Amazon::AWS
  include Amazon::AWS::Search

  ASSOCIATES_ID = "k0f65-20"
  KEY_ID = "1CCH6DMMGPQC7HMT2G82"
  
  def self.try(type="ASIN", key="B001COU9I6")
    if type =="ASIN"
      il = ItemLookup.new( type, { 'ItemId' => key,'MerchantId' => 'Amazon' })
    else
      il = ItemLookup.new( type, { 'ItemId' => key,'MerchantId' => 'Amazon',"SearchIndex"=>"All" })
    end
    rg = ResponseGroup.new( 'Medium' )

    req = Request.new(KEY_ID, ASSOCIATES_ID)
    puts req
    
    resp = req.search( il, rg)
    item_sets = resp.item_lookup_response[0].items
    item_sets.each do |item_set|
      item_set.item.each do |item|
        attribs = item.item_attributes[0]
        puts attribs
      end
    end
  end
  
  
  def self.do(type="ASIN", key="B001COU9I6")
    if type =="ASIN"
      il = ItemLookup.new( type, { 'ItemId' => key,'MerchantId' => 'Amazon' })
    else
      il = ItemLookup.new( type, { 'ItemId' => key,'MerchantId' => 'Amazon',"SearchIndex"=>"All" })
    end
    rg = ResponseGroup.new( 'Medium' )

    req = Request.new(KEY_ID, ASSOCIATES_ID)
    puts req
    
    resp = req.search( il, rg)
    item = resp.item_lookup_response[0].items.item
  end
  
  
  
  
  def self.lookup(type="ASIN", key="B001COU9I6")
    if type =="ASIN"
      il = ItemLookup.new( type, { 'ItemId' => key,'MerchantId' => 'Amazon' })
    else
      il = ItemLookup.new( type, { 'ItemId' => key,'MerchantId' => 'Amazon',"SearchIndex"=>"All" })
    end
    rg = ResponseGroup.new( 'Medium' )
    req = Request.new(KEY_ID, ASSOCIATES_ID)
    puts req
    
    resp = req.search( il, rg)
    item = resp.item_lookup_response[0].items[0].item
    item.item_attributes.to_h
=begin
    item_sets = resp.item_lookup_response[0].items
    item_sets.each do |item_set|
      item_set.item.each do |item|
        attribs = item.item_attributes[0]
        puts attribs
      end
    end
=end
  end
  
end
