require "book"

class PrerequisiteFactory

  def initialize(book_lesson)
    @book_lesson = book_lesson
  end

  def topic_codes
    @book_lesson.required_background.scan(Book::TOPIC_CODE_PATTERN)
  end

end
