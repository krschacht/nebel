require "book"
require "lesson_part_splitter"

class ExerciseFactory

  def initialize(book_lesson)
    @book_lesson = book_lesson
    @lesson_part_splitter = LessonPartSplitter.new(@book_lesson.methods_and_procedures)
  end

  def exercises
    @lesson_part_splitter.split do |part_number, part_name, part_text|
      duration   = @book_lesson.time_required[/^Part #{part_number}.*\(\s*(.*)\s*\)/, 1]
      duration ||= @book_lesson.time_required

      Exercise.new({
        name:      part_name,
        body:      part_text,
        duration:  duration,
        part:      part_number
      })
    end
  end

end
