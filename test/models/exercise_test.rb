require 'test_helper'

class ExerciseTest < ActiveSupport::TestCase
  test "validates presence of topic_id" do
    exercise = Exercise.new
    assert !exercise.valid?
    assert exercise.errors[:topic_id].include? "can't be blank"
  end

  test "validates presence of part" do
    exercise = Exercise.new part: nil
    assert !exercise.valid?
    assert exercise.errors[:part].include? "can't be blank"
  end

  test "part defaults to 1" do
    assert_equal 1, Exercise.new.part
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

  test "#name returns the name" do
    assert_equal "Foo", Exercise.new(name: "Foo").name
  end

  test "#name returns the part with the prefix 'Part '" do
    assert_equal "Part 3", Exercise.new(part: 3).name
  end
end
