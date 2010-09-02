# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  
  def item_types_list
    ItemType.all.collect { |i| [ i.name, i.id ] }
  end
  
  def creator_types_list
    CreatorType.all.collect { |i| [ i.name, i.id ] }
  end
  
  def key_types_list
    KeyType.all.collect { |i| [ i.name, i.id ] }
  end
end
