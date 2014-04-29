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

  test "archived is false by default" do
    assert !Material.new.archived
  end

  test "#archive sets archive to true" do
    material = materials(:straw)
    material.update archived: false
    material.archive
    assert material.reload.archived
  end

  test "#unarchive sets archive to false" do
    material = materials(:straw)
    material.update archived: true
    material.unarchive
    assert !material.reload.archived
  end

  test "#display_name" do
    assert_nil Material.new.display_name
    assert_equal "Foo", Material.new(name: "Foo").display_name
    assert_equal "Foo", Material.new(original_name: "Foo").display_name
  end

end
