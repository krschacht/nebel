require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  test "should get new" do
    get :new

    assert_response :success
    assert_template :new
  end

  test "should create a session" do
    user = users(:avand)
    user.password = "secret"
    user.save

    post :create, email: user.email.upcase, password: "secret"

    assert_redirected_to topics_url
    assert_equal user.id, session[:user_id]
    assert_equal flash[:notice], "Welcome back, #{user.name}."
  end

  test "should not create a session" do
    user = users(:avand)

    post :create, email: user.email, password: "mismatch"

    assert_response :success
    assert_template :new
    assert_equal flash[:alert], "Your email or password is incorrect."
    assert_nil session[:user_id]
  end

  test "should destroy a session" do
    session[:user_id] = 1

    delete :destroy

    assert_nil session[:user_id]
    assert_redirected_to root_url
  end

end
