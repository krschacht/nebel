require "book"
require "lesson_part_splitter"

class MaterialFactory

  def initialize(book_lesson)
    @materials_for_all_parts = []
    @materials_by_part       = []

    lesson_part_splitter = LessonPartSplitter.new(book_lesson.materials)

    lesson_part_splitter.split do |part_number, part_name, part_text|
      if part_text.present?
        lines = part_text.split("\n").reject(&:blank?)

        materials = lines.map do |line|
          Material.new original_name: line.strip
        end

        if part_number.nil?
          @materials_for_all_parts += materials
        else
          @materials_by_part[part_number] = materials
        end
      end
    end
  end

  def materials(part)
    materials  = @materials_for_all_parts
    materials += @materials_by_part[part] if @materials_by_part[part].present?
    materials
  end

end
