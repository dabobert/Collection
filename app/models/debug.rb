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
  
  
  def self.foo
    self.lookup(type="UPC", key="724383771509")
  end
  
  def self.isbn
    "9781582401836"
  end
  
  def self.lookup(type="ASIN", key="B001COU9I6")
    if type =="ASIN"
      il = ItemLookup.new( type, { 'ItemId' => key,'MerchantId' => 'Amazon' })
    elsif type == "UPC"
      il = ItemLookup.new( type, { 'ItemId' => key,'MerchantId' => 'Amazon',"SearchIndex"=>"Music", "IdTypeSpecified"=>"true" })
    else
      il = ItemLookup.new( type, { 'ItemId' => key,'MerchantId' => 'Amazon',"SearchIndex"=>"All" })
    end
    rg = ResponseGroup.new( 'Medium' )
    req = Request.new(KEY_ID, ASSOCIATES_ID)
    #puts req
    
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
  

  def self.baby
    is = ItemSearch.new( 'Baby',
      {
        'Keywords' => 'pants',
        'MinimumPrice' => '2500',
        'MaximumPrice' => '4999'
      } )
    is.response_group = ResponseGroup.new( 'Small' )

    req = Request.new
    req.locale = 'us'

    resp = req.search( is )
    items = resp.item_search_response[0].items[0].item

    items.each { |item| puts item, '' }
  end
  
  
  #054391982629
  #http://www.browsenodes.com/upc.php?upc=078636512822&tag=harrynilsson-20&keywords=Harry+Nilsson
  
  #B001COU9I6
  #http://www.amazon.co.uk/dp/B001COU9I6
  #http://www.amazon.com/dp/B001COU9I6
  #http://www.browsenodes.com/upc.php?upc=054391982629&tag=harrynilsson-20&keywords=Harry+Nilsson
  #http://www.browsenodes.com/upc.php?upc=054391982629&tag=harrynilsson-20&keywords=Harry+Nilsson
  def self.mp3
    is = ItemSearch.new( 'Baby',
      {
        'Keywords' => 'pants',
        'MinimumPrice' => '2500',
        'MaximumPrice' => '4999'
      } )
    is.response_group = ResponseGroup.new( 'Small' )

    req = Request.new
    req.locale = 'us'

    resp = req.search( is )
    items = resp.item_search_response[0].items[0].item

    items.each { |item| puts item, '' }
  end
end
