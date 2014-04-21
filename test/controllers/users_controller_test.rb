require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:avand)
  end

  test "GET to new renders new" do
    get :new

    assert_response :success
    assert_template :new
  end

  test "POST to create creates user and saves their ID in session" do
    User.delete_all

    assert_difference("User.count") do
      post :create, user: { email: @user.email, name: @user.name, password: @user.password }
    end

    assert_redirected_to topics_path
    assert_equal flash[:notice], "User was successfully created."
    assert_equal session[:user_id], assigns(:user).id
  end

  test "GET to edit requires a user" do
    get :edit, id: @user

    assert_user_required
  end

  test "GET to edit redirects if attempting to edit someone other than current_user" do
    login_as_user

    get :edit, id: users(:admin).id

    assert_redirected_to root_path
    assert_equal flash[:alert], "You are not allowed to do that."
  end

  test "GET to edit renders edit" do
    login_as_user

    get :edit, id: @user

    assert_response :success
    assert_equal assigns(:user), @user
    assert_template :edit
  end

  test "GET to edit with access token creates session" do
    get :edit, id: @user, access_token: @user.access_token

    assert_equal @user.id, session[:user_id]
    assert_response :success
    assert_equal "You are now signed in. Please consider changing your password.", flash[:notice]
  end

  test "PATCH to update requires a user" do
    patch :update, id: @user

    assert_user_required
  end

  test "PATCH to update redirects if attempting to edit someone other than current_user" do
    login_as_user

    patch :update, id: users(:admin).id

    assert_redirected_to root_path
    assert_equal flash[:alert], "You are not allowed to do that."
  end

  test "PATCH to update updates user" do
    login_as_user

    patch :update, id: @user, user: {
      email: @user.email, name: @user.name, password: @user.password
    }

    assert_redirected_to edit_user_path(assigns(:user))
    assert_equal assigns(:user), @user
    assert_equal flash[:notice], "User was successfully updated."
  end

  test "GET to forgot_password renders forgot_password" do
    get :forgot_password

    assert_response :success
    assert_template :forgot_password
  end

  test "POST to send_access_email renders forgot_password if user can't be found" do
    post :send_access_email, email: "foo@bar.com"

    assert_equal "There is no user with that email.", flash[:alert]
    assert_template :forgot_password
  end

  test "POST to send_access_email sends email and redirects to login" do
    post :send_access_email, email: @user.email

    assert_not ActionMailer::Base.deliveries.empty?
    assert_equal "Your access link has been sent! Please check your email.", flash[:notice]
    assert_redirected_to new_session_path
  end

end
