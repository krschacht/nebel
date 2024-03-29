require 'test_helper'

class ExercisesControllerTest < ActionController::TestCase

  setup do
    @exercise = exercises(:d5_part1)
  end

  test "GET to new requires an admin" do
    login_as_user

    get :new

    assert_admin_required
  end

  test "GET to new renders new" do
    login_as_admin

    get :new

    assert_response :success
    assert_template :new
  end

  test "POST to create requires an admin" do
    login_as_user

    post :create

    assert_admin_required
  end

  test "POST to create creates exercise" do
    login_as_admin
    @exercise.destroy

    assert_difference("Exercise.count") do
      post :create, exercise: {
        topic_id: @exercise.topic_id, name: @exercise.name
      }
    end

    assert_redirected_to edit_exercise_path(assigns(:exercise))
    assert_equal flash[:notice], "Exercise was successfully created."
  end

  test "GET to edit requires an admin" do
    login_as_user

    get :edit, id: @exercise

    assert_admin_required
  end

  test "GET to edit renders edit" do
    login_as_admin

    get :edit, id: @exercise

    assert_response :success
    assert_template :edit
    assert_equal assigns(:exercise), @exercise
  end

  test "PATCH to update requires admin" do
    login_as_user

    patch :update, id: @exercise

    assert_admin_required
  end

  test "PATCH to update updates exercise" do
    login_as_admin

    patch :update, id: @exercise, exercise: { body: @exercise.body, name: @exercise.name }

    assert_redirected_to edit_exercise_path(assigns(:exercise))
    assert_equal flash[:notice], "Exercise was successfully updated."
    assert_equal assigns(:exercise), @exercise
  end

end
