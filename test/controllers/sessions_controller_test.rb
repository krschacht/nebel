require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  test "GET to new renders new" do
    get :new

    assert_response :success
    assert_template :new
  end

  test "POST to create stores the user's ID in session" do
    user = users(:avand)
    user.password = "secret"
    user.save

    post :create, email: user.email.upcase, password: "secret"

    assert_redirected_to topics_url
    assert_equal user.id, session[:user_id]
    assert_equal flash[:notice], "Welcome back, #{user.name}."
  end

  test "POST to create does not store the user's ID in session if email or password don't match" do
    user = users(:avand)

    post :create, email: user.email, password: "mismatch"

    assert_response :success
    assert_template :new
    assert_equal flash[:alert], "Your email or password is incorrect."
    assert_nil session[:user_id]
  end

  test "POST to create redirects to session[:redirect_to]" do
    user = users(:avand)
    session[:redirect_to] = "/foo/bar"

    post :create, email: user.email, password: "secret"

    assert_redirected_to "/foo/bar"
    assert_nil session[:redirect_to]
  end

  test "DELETE to destroy requires a user" do
    delete :destroy

    assert_user_required
  end

  test "DELETE to destroy removes the user's ID from session" do
    login_as_user

    delete :destroy

    assert_nil session[:user_id]
    assert_redirected_to root_url
  end

end
