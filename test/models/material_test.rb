require 'test_helper'

class MaterialTest < ActiveSupport::TestCase
  test "validates presence of name" do
    material = Material.new
    assert !material.valid?
    assert material.errors[:name].include? "can't be blank"
  end

  test "validates presence of original_name" do
    material = Material.new
    assert !material.valid?
    assert material.errors[:original_name].include? "can't be blank"
  end


  test "has many requisitions" do
    material, exercise = materials(:straw), exercises(:d5_part1)
    requisition = Requisition.create! material_id: material.id, exercise_id: exercise.id
    assert material.reload.requisitions.include? requisition
  end

  test "has many exercises through requisitions" do
    material, exercise = materials(:straw), exercises(:d5_part1)
    requisition = Requisition.create! material_id: material.id, exercise_id: exercise.id
    assert material.reload.exercises.include? exercise
  end
end
