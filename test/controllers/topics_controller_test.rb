require 'test_helper'

class TopicsControllerTest < ActionController::TestCase
  setup do
    @topic = topics(:a2)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:subjects)
    assert_not_nil assigns(:topics_by_subject)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create topic" do
    @topic.destroy

    assert_difference('Topic.count') do
      post :create, topic: {
        subject_id: @topic.subject_id, code: @topic.code, name: @topic.name,
        order: @topic.order
      }
    end

    assert_redirected_to topic_path(assigns(:topic))
  end

  test "should show topic" do
    get :show, id: @topic, field: "overview"
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @topic
    assert_response :success
  end

  test "should update topic" do
    patch :update, id: @topic, topic: { code: @topic.code, name: @topic.name, overview: @topic.overview }
    assert_redirected_to topic_path(assigns(:topic))
  end

  test "should destroy topic" do
    assert_difference('Topic.count', -1) do
      delete :destroy, id: @topic
    end

    assert_redirected_to topics_path
  end
end
