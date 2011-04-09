class String
  def titlecase
    self.gsub(/\b\w/){$&.upcase}
  end
end