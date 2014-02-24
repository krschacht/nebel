require "book"

class TopicFactory

  def initialize(book_lesson)
    @book_lesson = book_lesson
  end

  def topic
    Topic.new({
      name:              nil,
      order:             nil,
      overview:          @book_lesson.overview,
      context:           @book_lesson.position,
      objectives:        @book_lesson.objectives,
      teachable_moments: @book_lesson.teachable_moments,
      questions:         @book_lesson.questions,
      parents:           @book_lesson.support,
      connections:       @book_lesson.connections,
      books:             @book_lesson.books
    })
  end

end
