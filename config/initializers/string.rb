class String
  
  def titlecase
    self.gsub("_"," ").gsub(/\b\w/){$&.upcase}
  end
  
  def strip_tags
  		self.gsub( %r{</?[^>]+?>}, '' ).gsub( %r{&lt;/?[^>]+?&gt;}, '' )
  	end
end