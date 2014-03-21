require 'test_helper'

class RequisitionTest < ActiveSupport::TestCase
  test "validates presence of exercise_id" do
    requisition = Requisition.new
    assert !requisition.valid?
    assert requisition.errors[:exercise_id].include? "can't be blank"
  end

  test "validates presence of material_id" do
    requisition = Requisition.new
    assert !requisition.valid?
    assert requisition.errors[:material_id].include? "can't be blank"
  end

  test "quantity defaults to 1" do
    assert_equal 1, Requisition.new.quantity
  end

  test "belongs to material and exercise" do
    material, exercise = materials(:straw), exercises(:d5_part1)
    requisition = Requisition.create!(material_id: material.id, exercise_id: exercise.id)
    requisition.reload
    assert_equal requisition.material, material
    assert_equal requisition.exercise, exercise
  end
end
