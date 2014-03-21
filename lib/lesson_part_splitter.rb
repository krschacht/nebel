class LessonPartSplitter

  def initialize(text)
    @text = replace_parts_with_part text
  end

  def split
    results = []

    if text_divided_into_parts?
      @text.scan(/^Part\s\d{1,2}.*$/).map.with_index do |part_name, i|
        part_number = i + 1
        part_name   = part_name.strip.gsub(/\.$/, "")
        part_name   = part_name.gsub(/Part\s\d{1,2}/, "Part #{part_number}")
        part_text   = text_for_part(part_number)

        results << yield(part_number, part_name, part_text)
      end
    else
      results << yield(nil, nil, @text)
    end

    results
  end

  def text_for_part(part_number)
    return @text unless text_divided_into_parts?

    # http://rubular.com/r/vm39sWyUyY
    not_last_part_pattern = /Part\s#{part_number}\.[^\n]*(.*)\nPart\s#{part_number + 1}\./m
    last_part_pattern     = /Part\s#{part_number}\.[^\n]*(.*)/m

    match   = @text[not_last_part_pattern, 1]
    match ||= @text[last_part_pattern, 1]

    match.try :clean
  end

private

  def text_divided_into_parts?
    @text =~ /^Part\s\d/
  end

  def replace_parts_with_part(text)
    text.gsub(/^Parts\s(\d{1,2})\./, 'Part \1.')
  end

end
