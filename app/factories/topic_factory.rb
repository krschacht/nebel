require "book"

class TopicFactory

  def initialize(book_lesson)
    @book_lesson = book_lesson
  end

  def topic(subject)
    subject.topics.find_or_initialize_by(code: @book_lesson.full_lesson_code).tap do |topic|
      topic.name              = name
      topic.order             = @book_lesson.number
      topic.overview          = @book_lesson.overview
      topic.progression       = @book_lesson.position
      topic.objectives        = @book_lesson.objectives
      topic.teachable_moments = @book_lesson.teachable_moments
      topic.questions         = @book_lesson.questions
      topic.parents           = @book_lesson.support
      topic.connections       = @book_lesson.connections
      topic.books             = @book_lesson.books
      topic.materials_text    = @book_lesson.materials
    end
  end

private

  def name
    @book_lesson.name.gsub("\n", " ").split(" ").map(&:strip).join(" ")
  end

end
