class String
  def titlecase
    self.gsub("_"," ").gsub(/\b\w/){$&.upcase}
  end
end