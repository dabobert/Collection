class MakeKeyTypes < ActiveRecord::Migration
  def self.up
    KeyType.create :name=>"isrc"
    KeyType.create :name=>"upc"
    KeyType.create :name=>"gpid"
    KeyType.create :name=>"asin"
    KeyType.create :name=>"isbn"
    KeyType.create :name=>"isbn-13"
  end

  def self.down
    KeyType.find_by_name("isrc").destroy
    KeyType.find_by_name("upc").destroy
    KeyType.find_by_name("gpid").destroy
    KeyType.find_by_name("asin").destroy
    KeyType.find_by_name("isbn").destroy
    KeyType.find_by_name("isbn-13").destroy
  end
end
