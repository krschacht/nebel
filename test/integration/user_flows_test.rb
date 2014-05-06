require "test_helper"

class UserFlowsTest < ActionDispatch::IntegrationTest

  test "redirect to where you were going after signing in" do
    get "/materials"
    assert_redirected_to root_path
    assert_equal "/materials", session[:redirect_to]

    post_via_redirect "/sessions", email: users(:avand).email, password: "secret"
    assert_equal "/materials", path
  end

end
