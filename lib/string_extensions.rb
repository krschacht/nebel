module StringExtensions
  def clean
    return nil if self.blank?
    self.gsub(/\u2028/, "\n").gsub(/(\A(\\n|\s)*|(\\n|\s)*\z)/, "")
  end
end
