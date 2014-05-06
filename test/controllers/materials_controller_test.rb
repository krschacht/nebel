require 'test_helper'

class MaterialsControllerTest < ActionController::TestCase

  setup do
    @material = materials(:straw)
  end

  test "GET to index requires a user" do
    get :index

    assert_user_required
  end

  test "GET to index loads material quantities by subject code and renders index for users" do
    login_as_user

    get :index

    assert_response :success
    assert_nil assigns(:materials)
    assert_not_nil assigns(:quantities_by_material_name_by_subject_code)
    assert_equal [1], assigns(:quantities_by_material_name_by_subject_code)["A"]["Dirt"]
    assert_equal [1], assigns(:quantities_by_material_name_by_subject_code)["A"]["Glue"]
    assert_equal [1], assigns(:quantities_by_material_name_by_subject_code)["A"]["Straw"]
    assert_equal [1], assigns(:quantities_by_material_name_by_subject_code)["D"]["Straw"]
    assert_template "index/user"
  end

  test "GET to index loads materials and renders index for admins" do
    login_as_admin

    get :index

    assert_nil assigns(:quantities_by_material_name_by_subject_code)
    assert_not_nil assigns(:materials)
    assert_template "index/admin"
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

  test "POST to create creates material" do
    login_as_admin

    assert_difference("Material.count") do
      post :create, material: { name: @material.name, url: @material.url }
    end

    assert_redirected_to edit_material_path(assigns(:material))
    assert_equal flash[:notice], "Material was successfully created."
  end

  test "GET to edit requires an admin" do
    login_as_user

    get :edit, id: @material

    assert_admin_required
  end

  test "GET to edit loads material and renders edit" do
    login_as_admin

    get :edit, id: @material

    assert_equal assigns(:material), @material
    assert_response :success
    assert_template :edit
  end

  test "PATCH to update requires an admin" do
    login_as_user

    patch :update, id: @material

    assert_admin_required
  end

  test "PATCH to update updates material" do
    login_as_admin

    patch :update, id: @material, material: {
      name: @material.name, url: @material.url
    }

    assert_equal assigns(:material), @material
    assert_redirected_to edit_material_path(assigns(:material))
    assert_equal flash[:notice], "Material was successfully updated."
  end

  test "DELETE to destroy requires an admin" do
    login_as_user

    delete :destroy, id: @material

    assert_admin_required
  end

  test "DELETE to destroy destroys material" do
    login_as_admin

    delete :destroy, id: @material

    assert_equal assigns(:material), @material
    assert @material.reload.archived
    assert_redirected_to materials_path
    assert_equal flash[:notice], "Material was successfully archived."
  end

  test "POST to merge requires an admin" do
    login_as_user

    post :merge

    assert_admin_required
  end

  test "POST to merge merges materials together" do
    login_as_admin

    Requisition.delete_all

    winner  = materials(:straw)
    loser_1 = materials(:glue)
    loser_2 = materials(:dirt)

    d5_part1 = exercises(:d5_part1)
    a3_part2 = exercises(:a3_part2)
    a2_part1 = exercises(:a2_part1)

    d5_part1.materials << winner
    a3_part2.materials << loser_1
    a2_part1.materials << loser_2

    post :merge, winner_id: winner.id, loser_ids: [loser_1.id, loser_2.id]

    assert_redirected_to edit_material_path(winner, exercise_ids: [a3_part2.id, a2_part1.id])
    assert loser_1.reload.archived
    assert loser_2.reload.archived
    assert_equal 3, winner.exercises.count
    assert winner.exercises.include?(d5_part1)
    assert winner.exercises.include?(a3_part2)
    assert winner.exercises.include?(a2_part1)

    links = [
      canonical_topic_path(a3_part2.topic.slug, anchor: "part-#{a3_part2.part}"),
      canonical_topic_path(a2_part1.topic.slug, anchor: "part-#{a2_part1.part}")
    ]

    assert_equal %Q{Exercise(s) <a href="#{links[0]}" target="_blank">#{a3_part2.id}</a> and <a href="#{links[1]}" target="_blank">#{a2_part1.id}</a> are now associated to this material.}, flash[:notice]
  end

end
