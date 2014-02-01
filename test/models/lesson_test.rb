require 'test_helper'

class LessonTest < ActiveSupport::TestCase
  test "validates presence of name" do
    lesson = Lesson.new
    assert !lesson.valid?
    assert lesson.errors[:name].include? "can't be blank"
  end

  test "belongs to topic" do
    assert_equal topics(:d5), lessons(:d5_part1).topic
  end
end
