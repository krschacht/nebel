require 'test_helper'

class RequisitionsControllerTest < ActionController::TestCase

  test "DELETE to destroy requires an admin" do
    login_as_user

    delete :destroy

    assert_admin_required
  end

  test "DELETE to destroy destroys requisition" do
    login_as_admin

    material = materials(:straw)
    exercise = exercises(:d5_part1)

    Requisition.create(exercise_id: exercise.id, material_id: material.id)

    delete :destroy, exercise_id: exercise.id, material_id: material.id

    assert_empty Requisition.where(exercise_id: exercise.id, material_id: material.id)
  end

end
