class ItemLookup
  require 'amazon_product'
  
  attr_accessor :data, :request, :response
  
  def self.find(attr)
    request = AmazonProduct["us"]
    request.configure do |c| 
      c.key    = AMAZON_PRODUCT_KEY
      c.secret = AMAZON_PRODUCT_SECRET
      c.tag    = AMAZON_PRODUCT_TAG
    end
    
    if attr.class == Hash
      request << attr
    elsif attr.class == String
      request.search(attr)
    else
      raise "ItemLookup::find Wtf did you give me to parse"
    end
    
    request << {:response_group=>"Large"}
    response = request.get
    
    data = response.find("Item")
    
    if response.has_errors?
      raise response.errors[0]["Message"]
    else
      response
    end
  end
end
