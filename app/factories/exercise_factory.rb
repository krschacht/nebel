require "book"
require "lesson_part_splitter"

class ExerciseFactory

  def initialize(book_lesson)
    @book_lesson = book_lesson
    @lesson_part_splitter = LessonPartSplitter.new(@book_lesson.methods_and_procedures)
  end

  def exercises(topic)
    @lesson_part_splitter.split do |part_number, part_name, part_text|
      part_number ||= 1

      topic.exercises.find_or_initialize_by(part: part_number).tap do |exercise|
        exercise.name     = part_name
        exercise.body     = part_text
      end
    end
  end

end
