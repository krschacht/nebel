require "book"
require "lesson_part_splitter"

class ExerciseFactory

  def initialize(book_lesson)
    @book_lesson = book_lesson
    @lesson_part_splitter = LessonPartSplitter.new(@book_lesson.methods_and_procedures)
  end

  def exercises(topic)
    @lesson_part_splitter.split do |part_number, part_name, part_text|
      duration      = @book_lesson.time_required[/^Part #{part_number}.*\(\s*(.*)\s*\)/, 1]
      duration    ||= @book_lesson.time_required
      part_number ||= 1

      topic.exercises.find_or_initialize_by(part: part_number) do |exercise|
        exercise.name     = part_name
        exercise.body     = part_text
        exercise.duration = duration
      end
    end
  end

end
