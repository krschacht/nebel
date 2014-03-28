require "test_helper"

class MessagesControllerTest < ActionController::TestCase

  include MessagesHelper

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
    assert_redirected_to message_path(message)
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
    assert_redirected_to message_path(message)
    assert_equal "Your message has been posted.", flash[:notice]
  end

  test "POST to create redirects to the root_path if the message can't be saved" do
    login_as_user

    post :create, message: { subject: nil }

    assert_redirected_to root_path
    assert_equal "There was an error posting your message.", flash[:alert]
  end

end
