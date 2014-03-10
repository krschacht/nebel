require "book"
require "lesson_part_splitter"

class MaterialFactory

  def initialize(book_lesson)
    @lesson_part_splitter = LessonPartSplitter.new(book_lesson.materials)
  end

  def materials
    @lesson_part_splitter.split do |part_number, part_name, part_text|
      lines = part_text.split("\n").reject(&:blank?)

      lines.map do |line|
        Material.new original_name: line
      end
    end
  end

end
