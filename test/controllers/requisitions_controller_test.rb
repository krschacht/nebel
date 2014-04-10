require 'test_helper'

class RequisitionsControllerTest < ActionController::TestCase

  test "DELETE to destroy requires an admin" do
    login_as_user

    delete :destroy, id: 1

    assert_admin_required
  end

  test "DELETE to destroy destroys requisition" do
    login_as_admin

    material = materials(:straw)
    exercise = exercises(:d5_part1)

    requisition = Requisition.create(exercise_id: exercise.id, material_id: material.id)

    delete :destroy, id: requisition.id

    assert_empty Requisition.where(exercise_id: exercise.id, material_id: material.id)
  end

  test "POST to create requires an admin" do
    login_as_user

    post :create, requisition: { material_id: 1, exercise_id: 1, quantity: 1 }

    assert_admin_required
  end

  test "POST to create redirects with a message if requisition can't be saved" do
    login_as_admin

    post :create, requisition: { material_id: 1, exercise_id: nil, quantity: 1 }

    assert_redirected_to edit_material_path( 1 )
    assert_equal "There was an error linking this material.", flash[:alert]
  end

  test "POST to create creates a requisition" do
    login_as_admin

    material = materials(:straw)
    exercise = exercises(:d5_part1)

    post :create, requisition: { material_id: material.id, exercise_id: exercise.id, quantity: 1 }

    assert_redirected_to edit_material_path( material.id )
    assert_match /^That material is now linked to exercise /, flash[:notice]
  end

  test "PATCH to update requires an admin" do
    login_as_user

    patch :update, id: 1

    assert_admin_required
  end

  test "PATCH to update successfully if quantity is blank" do
    login_as_admin

    material = materials(:straw)
    exercise = exercises(:d5_part1)

    requisition = Requisition.create(exercise_id: exercise.id, material_id: material.id)

    patch :update, id: requisition.id, requisition: { material_id: material.id, exercise_id: exercise.id, quantity: nil }
    requisition = Requisition.find( requisition.id )

    assert_redirected_to edit_material_path( material.id )
    assert_equal "The quantity was updated.", flash[:notice]
    assert_equal nil, requisition.quantity
  end

  test "PATCH to update successfully updates the quantity" do
    login_as_admin

    material = materials(:straw)
    exercise = exercises(:d5_part1)

    requisition = Requisition.create(exercise_id: exercise.id, material_id: material.id)

    patch :update, id: requisition.id, requisition: { material_id: material.id, exercise_id: exercise.id, quantity: 2 }
    requisition = Requisition.find( requisition.id )

    assert_redirected_to edit_material_path( material.id )
    assert_equal "The quantity was updated.", flash[:notice]
    assert_equal 2, requisition.quantity
  end

end
