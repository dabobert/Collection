class SingleValueModel < ActiveRecord::Base
  self.abstract_class = true
  
  def self.construct value
    value.downcase!
    self.base_class.find_by_name(value) || self.base_class.create(:name=>value)
  end

end
