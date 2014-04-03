require "test_helper"

class MessagesControllerTest < ActionController::TestCase

  include MessagesHelper

  test "GET to show requires an admin" do
    login_as_user

    get :show, id: messages(:opener).id

    assert_admin_required
  end

  test "GET to show renders show" do
    login_as_admin

    get :show, id: messages(:opener).id

    assert_response :success
    assert_template :show
    assert_equal messages(:opener), assigns(:message)
  end

  test "GET to index requires an admin" do
    login_as_user

    get :index

    assert_admin_required
  end

  test "GET to index renders index" do
    login_as_admin

    get :index

    assert_response :success
    assert_template :index
  end

  test "GET to index filters to opened messages by default" do
    login_as_admin

    get :index

    assert assigns(:messages).include? messages(:opener)
    assert assigns(:messages).exclude? messages(:closed)
  end

  test "GET to index filters to closed messages" do
    login_as_admin

    get :index, scope: "closed"

    assert assigns(:messages).include? messages(:closed)
    assert assigns(:messages).exclude? messages(:opener)
  end

  test "GET to index filters to archived messages by default" do
    login_as_admin

    get :index

    assert assigns(:messages).exclude? messages(:archived)
  end

  test "POST to create requires a user" do
    post :create

    assert_user_required
  end

  test "POST to create creates an opener and redirects to it" do
    login_as_user

    topic = topics(:a2)

    post :create, message: {
      object_type: topic.class.name, object_id: topic.id,
      subject: "What is the meaning of life?", body: "..."
    }

    message = Message.last

    assert_equal "Topic", message.object_type
    assert_equal topic.id, message.object_id
    assert_equal "What is the meaning of life?", message.subject
    assert_equal "...", message.body
    assert_equal session[:user_id], message.author_id
    assert_redirected_to canonical_message_path(message)
    assert_equal "Your message has been posted.", flash[:notice]
  end

  test "POST to create creates a reply and redirects to it" do
    login_as_user

    opener = messages(:opener)

    post :create, message: {
      object_type: opener.class.name, object_id: opener.id,
      body: "..."
    }

    message = Message.last

    assert_equal "Message", message.object_type
    assert_equal opener.id, message.object_id
    assert_equal opener.subject, message.subject
    assert_equal "...", message.body
    assert_equal session[:user_id], message.author_id
    assert_redirected_to canonical_message_path(message)
    assert_equal "Your message has been posted.", flash[:notice]
  end

  test "POST to create redirects to the root_path if the message can't be saved" do
    login_as_user

    post :create, message: { subject: nil }

    assert_redirected_to root_path
    assert_equal "There was an error posting your message.", flash[:alert]
  end

  test "PATCH to toggle requires an admin" do
    login_as_user

    patch :toggle, id: messages(:opener).id

    assert_admin_required
  end

  test "PATCH to toggle renders toggle" do
    login_as_admin

    patch :toggle, id: messages(:opener).id

    assert_response :success
    assert_template :toggle
    assert assigns(:message)
  end

  test "PATCH to toggle changes open from true to false" do
    login_as_admin

    message = messages(:opener)
    message.update_attribute :opened, true

    patch :toggle, id: message.id

    assert !message.reload.opened
  end

  test "PATCH to toggle changes open from false to true" do
    login_as_admin

    message = messages(:opener)
    message.update_attribute :opened, false

    patch :toggle, id: message.id

    assert message.reload.opened
  end

  test "DELETE to destroy requires an admin" do
    login_as_user

    delete :destroy, id: messages(:opener).id

    assert_admin_required
  end

  test "DELETE to destroy archives the message" do
    login_as_admin

    delete :destroy, id: messages(:opener).id

    assert messages(:opener).reload.archived
    assert_response :success
    assert_template :destroy
  end

end
