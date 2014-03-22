require 'test_helper'

class MaterialsControllerTest < ActionController::TestCase
  setup do
    @material = materials(:straw)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:materials)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create material" do
    assert_difference('Material.count') do
      post :create, material: { name: @material.name, url: @material.url }
    end

    assert_redirected_to material_path(assigns(:material))
  end

  test "should get edit" do
    get :edit, id: @material
    assert_response :success
  end

  test "should update material" do
    patch :update, id: @material, material: { name: @material.name, url: @material.url }
    assert_redirected_to material_path(assigns(:material))
  end

  test "should destroy material" do
    assert_difference('Material.count', -1) do
      delete :destroy, id: @material
    end

    assert_redirected_to materials_path
  end

  test "should merge materials together" do
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
    assert_equal %Q{Exercise(s) <a href="#{exercise_path a3_part2}" target="_blank">#{a3_part2.id}</a> and <a href="#{exercise_path a2_part1}" target="_blank">#{a2_part1.id}</a> are now associated to this material.}, flash[:notice]
  end

end
