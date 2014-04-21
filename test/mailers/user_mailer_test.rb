require "../test_helper"

class UserMailerTest < ActionMailer::TestCase

  include Rails.application.routes.url_helpers

  def default_url_options
    Rails.application.config.action_mailer.default_url_options
  end

  test "forgot_password" do
    user = users(:avand)
    email = UserMailer.forgot_password(user).deliver

    assert_not ActionMailer::Base.deliveries.empty?
    assert_equal ["do-not-reply@nebelscience.com"], email.from
    assert_equal [user.email], email.to
    assert_equal "[Nebel Science] Forgot your password?", email.subject
    assert email.body.include? edit_user_url(user, access_token: user.access_token)
  end

end
