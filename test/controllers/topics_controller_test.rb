require 'test_helper'

class TopicsControllerTest < ActionController::TestCase

  setup do
    @topic = topics(:a2)
  end

  test "GET to index requires a current user" do
    get :index

    assert_user_required
  end

  test "GET to index loads subjects and topics by subject and renders index" do
    login_as_user

    get :index

    assert_response :success
    assert_template :index
    assert_not_nil assigns(:subjects)
    assert_not_nil assigns(:topics_by_subject)
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
  end

  test "POST to create requires an admin" do
    login_as_user

    post :create

    assert_admin_required
  end

  test "POST to create creates a topic and redirects to it" do
    login_as_admin
    @topic.destroy

    assert_difference("Topic.count") do
      post :create, topic: {
        subject_id: @topic.subject_id, code: @topic.code, name: @topic.name,
        order: @topic.order
      }
    end

    assert_redirected_to edit_topic_path(assigns(:topic))
    assert_equal flash[:notice], "Topic was successfully created."
  end

  test "GET to show loads topic and renders show" do
    login_as_user

    get :show, slug: @topic.slug, field: "overview"

    assert_response :success
    assert_equal @topic, assigns(:topic)
    assert_template :show
  end

  test "GET to edit requires an admin" do
    login_as_user

    get :edit, id: @topic

    assert_admin_required
  end

  test "GET to edit loads topic and renders edit" do
    login_as_admin

    get :edit, id: @topic

    assert_response :success
    assert_template :edit
    assert_equal @topic, assigns(:topic)
  end

  test "PATCH to update requires an admin" do
    login_as_user

    patch :update, id: @topic

    assert_admin_required
  end

  test "PATCH to update updates the topic and redirects to it" do
    login_as_admin

    patch :update, id: @topic, topic: {
      code: @topic.code, name: @topic.name, overview: @topic.overview
    }

    assert_redirected_to edit_topic_path(assigns(:topic))
    assert_equal flash[:notice], "Topic was successfully updated."
    assert_equal @topic, assigns(:topic)
  end

  test "DELETE to destroy requires an admin" do
    login_as_user

    delete :destroy, id: @topic

    assert_admin_required
  end

  test "DELETE to destroy destroys topic" do
    login_as_admin

    assert_difference("Topic.count", -1) do
      delete :destroy, id: @topic
    end

    assert_redirected_to topics_path
    assert_equal flash[:notice], "Topic was successfully destroyed."
    assert_equal @topic, assigns(:topic)
  end

end
