require "test_helper"

class PrerequisiteFactoryTest < ActiveSupport::TestCase

  setup do
    fixtures_root = Rails.root.join "test/fixtures/lesson_samples/"
    @a2  = Book::Lesson.new fixtures_root.join "volume_1/2nd_edition/a2.txt"
    @a18 = Book::Lesson.new fixtures_root.join "volume_2/2nd_edition/a18.txt"
    @a22 = Book::Lesson.new fixtures_root.join "volume_3/1st_edition/a22.txt"
    @b22 = Book::Lesson.new fixtures_root.join "volume_2/2nd_edition/b22.txt"
    @b30 = Book::Lesson.new fixtures_root.join "volume_3/1st_edition/b30.txt"
    @c5  = Book::Lesson.new fixtures_root.join "volume_1/2nd_edition/c5.txt"
    @c10 = Book::Lesson.new fixtures_root.join "volume_2/2nd_edition/c10.txt"
    @d5  = Book::Lesson.new fixtures_root.join "volume_1/2nd_edition/d5.txt"
    @d14 = Book::Lesson.new fixtures_root.join "volume_3/1st_edition/d14.txt"
  end

  test "#topic_codes" do
    topic_codes = PrerequisiteFactory.new(@a2).topic_codes
    assert_equal 1, topic_codes.size
    assert topic_codes.include? "A/B-1"

    topic_codes = PrerequisiteFactory.new(@a18).topic_codes
    assert_equal 3, topic_codes.size
    assert topic_codes.include? "A-15"
    assert topic_codes.include? "A-17"
    assert topic_codes.include? "D-9"

    topic_codes = PrerequisiteFactory.new(@a22).topic_codes
    assert_equal 2, topic_codes.size
    assert topic_codes.include? "A-20"
    assert topic_codes.include? "A-21"

    topic_codes = PrerequisiteFactory.new(@b22).topic_codes
    assert_equal 3, topic_codes.size
    assert topic_codes.include? "B-21"
    assert topic_codes.include? "B-13"
    assert topic_codes.include? "B-14"

    topic_codes = PrerequisiteFactory.new(@b30).topic_codes
    assert_equal 4, topic_codes.size
    assert topic_codes.include? "A-20"
    assert topic_codes.include? "B-18"
    assert topic_codes.include? "B-27"
    assert topic_codes.include? "B-28"

    topic_codes = PrerequisiteFactory.new(@c5).topic_codes
    assert_equal 4, topic_codes.size
    assert topic_codes.include? "C-1"
    assert topic_codes.include? "C-3"
    assert topic_codes.include? "C-3A"
    assert topic_codes.include? "C-4"

    topic_codes = PrerequisiteFactory.new(@c10).topic_codes
    assert_equal 4, topic_codes.size
    assert topic_codes.include? "C-1"
    assert topic_codes.include? "C-3"
    assert topic_codes.include? "C-5"
    assert topic_codes.include? "C-6"

    topic_codes = PrerequisiteFactory.new(@d5).topic_codes
    assert_equal 3, topic_codes.size
    assert topic_codes.include? "D-2"
    assert topic_codes.include? "D-3"
    assert topic_codes.include? "D-3A"

    topic_codes = PrerequisiteFactory.new(@d14).topic_codes
    assert_equal 2, topic_codes.size
    assert topic_codes.include? "D-6"
    assert topic_codes.include? "D-7"
  end

end
