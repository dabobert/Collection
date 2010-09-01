# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def crud_header(object)
      "<h2>#{object.new_record? ? "New" : "Edit"} #{object.class.name}</h2>"
  end
   
  def crud_submit(object)
      submit_tag "#{object.new_record? ? "Create!" : "Save Changes"}", :disable_with => "Please wait...", :id=>"submit_#{object.new_record? ? "new_"+object.class.name.underscore : object.class.name.underscore+"_"+object.id.to_s}"
  end
end
