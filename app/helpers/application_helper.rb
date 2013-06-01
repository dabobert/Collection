# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def errors_for(object)
    object.errors.full_messages.collect do |msg|
      "<p>#{msg}</p>"
    end.to_s
  end


  end

  def crud_header(object)
      "<h2>#{object.new_record? ? "New" : "Edit"} #{object.class.name}</h2>"
  end
   
  def crud_submit(object)
      submit_tag "#{object.new_record? ? "Create!" : "Save Changes"}", :disable_with => "Please wait...", :id=>"submit_#{object.new_record? ? "new_"+object.class.name.underscore : object.class.name.underscore+"_"+object.id.to_s}"
  end
  
  def metadata_labeler type
    type.downcase!
    case type
      when "category"
        "Categori(es)"
      else
        type.titlecase+"(s)"
    end
  end
  
  def cropped_thumbnail item, attr={}
    if item.thumbnail_width > 50
      crop_offset   = (item.thumbnail_width-49)/2
      attr[:style]  = "margin-left:-#{crop_offset}px; margin-right:0px;"
      image_tag(item.thumbnail, attr)
      image_tag(item.thumbnail, :style=>"margin-left:-#{crop_offset*2}px; margin-right:0px;")
    else
      image_tag(item.thumbnail)
    end
  end
end
