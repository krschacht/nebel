require "test_helper"
require "lesson_part_splitter"

class LessonPartSplitterTest < ActiveSupport::TestCase
  setup do
    @string_with_parts    = "Part 1. Wash\nWash the dishes\nPart 2. Rinse\nRinse the dishes"
    @string_without_parts = "Wash and rinse the dishes"
  end

  test "#split yields for each part" do
    lesson_part_splitter = LessonPartSplitter.new(@string_with_parts)
    count_of_yields      = 0

    lesson_part_splitter.split { count_of_yields += 1 }

    assert_equal 2, count_of_yields
  end

  test "#split yields with the part number" do
    lesson_part_splitter = LessonPartSplitter.new(@string_with_parts)
    part_numbers         = []

    lesson_part_splitter.split do |part_number|
      part_numbers << part_number
    end

    assert part_numbers.include? 1
    assert part_numbers.include? 2
  end

  test "#split yields with the part name" do
    lesson_part_splitter = LessonPartSplitter.new(@string_with_parts)
    part_names           = []

    lesson_part_splitter.split do |part_number, part_name|
      part_names << part_name
    end

    assert part_names.include? "Part 1. Wash"
    assert part_names.include? "Part 2. Rinse"
  end

  test "#split yields with the part text" do
    lesson_part_splitter = LessonPartSplitter.new(@string_with_parts)
    part_texts           = []

    lesson_part_splitter.split do |part_number, part_name, part_text|
      part_texts << part_text
    end

    assert part_texts.include? "Wash the dishes"
    assert part_texts.include? "Rinse the dishes"
  end

  test "#split yields once if text is not divided into parts" do
    lesson_part_splitter = LessonPartSplitter.new(@string_without_parts)
    count_of_yields      = 0

    lesson_part_splitter.split { count_of_yields += 1 }

    assert_equal 1, count_of_yields
  end

  test "#split yields part number as nil if text is not divided into parts" do
    lesson_part_splitter = LessonPartSplitter.new(@string_without_parts)

    lesson_part_splitter.split do |part_number|
      assert_nil part_number
    end
  end

  test "#split yields part name as nil if text is not divided into parts" do
    lesson_part_splitter = LessonPartSplitter.new(@string_without_parts)

    lesson_part_splitter.split do |part_number, part_name|
      assert_nil part_name
    end
  end

  test "#split yields part text if text is not divided into parts" do
    lesson_part_splitter = LessonPartSplitter.new(@string_without_parts)

    lesson_part_splitter.split do |part_number, part_name, part_text|
      assert_equal @string_without_parts, part_text
    end
  end

  test "#split returns an array of the results of each yield" do
    lesson_part_splitter = LessonPartSplitter.new(@string_with_parts)
    results              = lesson_part_splitter.split { "result" }

    assert_equal 2, results.size
    assert "result", results[0]
    assert "result", results[1]
  end

  test "#split fixes incorrectly labled part numbers" do
    lesson_part_splitter = LessonPartSplitter.new("Part 1. Wash\nPart 3. Rinse\nPart 5. Repeat")
    part_names           = []

    lesson_part_splitter.split do |part_number, part_name|
      part_names << part_name
    end

    assert_equal "Part 1. Wash", part_names[0]
    assert_equal "Part 2. Rinse", part_names[1]
    assert_equal "Part 3. Repeat", part_names[2]
  end

  test "#text_for_part extracts text between two parts" do
    lesson_part_splitter = LessonPartSplitter.new(@string_with_parts)

    assert_equal "Wash the dishes", lesson_part_splitter.text_for_part(1)
  end

  test "#text_for_part extracts text from last part" do
    lesson_part_splitter = LessonPartSplitter.new(@string_with_parts)

    assert_equal "Rinse the dishes", lesson_part_splitter.text_for_part(2)
  end

  test "#text_for_part extracts all text when not split into parts" do
    lesson_part_splitter = LessonPartSplitter.new(@string_without_parts)

    assert_equal "Wash and rinse the dishes", lesson_part_splitter.text_for_part(1)
  end
end
