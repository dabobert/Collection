AMAZON_PRODUCT_KEY    = "1CCH6DMMGPQC7HMT2G82"
AMAZON_PRODUCT_SECRET = "o8pTDZmDBE7mnJ9HlLpza8mOj5Rmrbp7f9omYps6"
AMAZON_PRODUCT_TAG   = "k0f65-20"

module AmazonProduct
  # A wrapper around the API response.
  class Response

    def find_value(attribute)
      value = find(attribute)
      if value.size == 1
        if value[0].class == String
          value[0].to_s
        else
          value[0]
        end
      elsif value.size == 2 && value[0] == value[1]
        value[0]
      else
        case attribute
          when "SmallImage"
            self.small_image
          else
            value
        end
      end
    end


    def clean_title
      case self.find_value("ProductGroup").downcase
        when "book"
          xml.xpath("//xmlns:ItemAttributes/xmlns:Title").text.gsub("Volume", "Vol.").gsub(", Vol", " Vol").gsub("Vol ", "Vol. ").gsub(/Vol. (([1-9])[^0-9]|([1-9])$)/, 'Vol. 0\1').gsub("- Vol.","Vol.")
        else
          str
      end
    end


    def small_image
      node_set = xml.xpath("//xmlns:SmallImage[xmlns:Height=75 and xmlns:Width<=49]")
      if node_set.count == 2
        if node_set[0].text == node_set[1].text
          node_set[0]
        else
          node_set
        end
      else
        raise "AmazonProduct::Response.small_image has more than 2 small images"
      end
    end

  end
end