require 'test_helper'

class ExerciseTest < ActiveSupport::TestCase
  test "validates presence of name" do
    exercise = Exercise.new
    assert !exercise.valid?
    assert exercise.errors[:name].include? "can't be blank"
  end

  test "validates presence of topic_id" do
    exercise = Exercise.new
    assert !exercise.valid?
    assert exercise.errors[:topic_id].include? "can't be blank"
  end

  test "belongs to topic" do
    assert_equal topics(:d5), exercises(:d5_part1).topic
  end
end
