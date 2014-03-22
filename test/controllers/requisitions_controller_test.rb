require 'test_helper'

class RequisitionsControllerTest < ActionController::TestCase
  test "should destroy a requisition" do
    material = materials(:straw)
    exercise = exercises(:d5_part1)

    Requisition.create(exercise_id: exercise.id, material_id: material.id)

    delete :destroy, exercise_id: exercise.id, material_id: material.id

    assert_empty Requisition.where(exercise_id: exercise.id, material_id: material.id)
  end
end
