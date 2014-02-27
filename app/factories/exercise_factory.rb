require "book"

class ExerciseFactory

  def initialize(book_lesson)
    @book_lesson = book_lesson
  end

  def exercises
    part_names = @book_lesson.methods_and_procedures.scan(/^Part\s\d{1,2}.*$/)
    part_names.map.with_index do |part_name, i|
      clean_part_name = part_name.strip.gsub(/\.$/, "")
      part_index      = i + 1
      body            = text_between_parts(@book_lesson.methods_and_procedures, part_index)
      materials       = text_between_parts(@book_lesson.materials, part_index)
      materials     ||= @book_lesson.materials
      duration        = @book_lesson.time_required[/^Part #{i + 1}.*\(\s*(.*)\s*\)/, 1]
      duration      ||= @book_lesson.time_required

      Exercise.new({
        name:      clean_part_name,
        body:      body,
        duration:  duration,
        materials: materials
      })
    end
  end

private

  def text_between_parts(text, part_index)
    # http://rubular.com/r/vm39sWyUyY
    not_last_part_pattern = /Part\s#{part_index}\.[^\n]*(.*)\nPart\s#{part_index + 1}\./m
    last_part_pattern     = /Part\s#{part_index}\.[^\n]*(.*)/m

    match   = text[not_last_part_pattern, 1]
    match ||= text[last_part_pattern, 1]

    match.try :clean
  end

end
