require "book"
require "lesson_part_splitter"

class MaterialFactory

  def initialize(book_lesson)
    @lesson_part_splitter = LessonPartSplitter.new(book_lesson.materials)
  end

  def materials(exercise)
    @lesson_part_splitter.split do |part_number, part_name, part_text|
      if part_text.present?
        lines = part_text.split("\n").reject(&:blank?)

        lines.map do |line|
          if part_number.nil? || part_number == exercise.part
            exercise.materials.find_or_initialize_by(original_name: line.strip)
          end
        end
      end
    end.flatten.compact
  end

end
