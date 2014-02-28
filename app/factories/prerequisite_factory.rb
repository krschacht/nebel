require "book"

class PrerequisiteFactory

  def initialize(book_lesson)
    @book_lesson = book_lesson
  end

  def topic_codes
    # http://rubular.com/r/N2ZDxweEjo
    @book_lesson.required_background.scan(/[ABCD]\/?-?[ABCD]?-\d{1,2}[ABCD]?/)
  end

end
