require "book"

class TopicFactory

  def initialize(book_lesson)
    @book_lesson = book_lesson
  end

  def topic
    Topic.new({
      name:              name,
      order:             @book_lesson.number,
      code:              @book_lesson.full_lesson_code,
      overview:          @book_lesson.overview,
      progression:       @book_lesson.position,
      objectives:        @book_lesson.objectives,
      teachable_moments: @book_lesson.teachable_moments,
      questions:         @book_lesson.questions,
      parents:           @book_lesson.support,
      connections:       @book_lesson.connections,
      books:             @book_lesson.books
    })
  end

private

  def name
    @book_lesson.name.gsub("\n", " ").split(" ").map(&:strip).join(" ")
  end

end
