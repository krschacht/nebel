class TopicSlug
  def initialize(code)
    @code = code
  end

  def slug
    @code.downcase.gsub("/", "")
  end
end
