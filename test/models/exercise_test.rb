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

  test "has many requisitions" do
    exercise, material = exercises(:d5_part1), materials(:straw)
    requisition = Requisition.create! exercise_id: exercise.id, material_id: material.id
    assert exercise.reload.requisitions.include? requisition
  end

  test "has many materials through requisitions" do
    exercise, material = exercises(:d5_part1), materials(:straw)
    requisition = Requisition.create! exercise_id: exercise.id, material_id: material.id
    assert exercise.reload.materials.include? material
  end
end
