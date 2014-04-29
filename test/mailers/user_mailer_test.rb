require "test_helper"

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

  test "new_message_posted" do
    message = messages(:opener)

    email = UserMailer.new_message_posted(message).deliver

    assert_not ActionMailer::Base.deliveries.empty?
    assert_equal ["do-not-reply@nebelscience.com"], email.from
    assert_equal "[Nebel Science] New message posted.", email.subject
    assert email.body.include? message_url(message)
  end

  test "new_message_posted indicates reply in subject" do
    email = UserMailer.new_message_posted(messages(:reply)).deliver
    assert_equal "[Nebel Science] New reply posted.", email.subject
  end

  test "new_message_posted bcc's admins" do
    email = UserMailer.new_message_posted(messages(:opener)).deliver
    assert_equal [users(:admin).email], email.bcc
  end

  test "new_message_posted bcc's everyone on thread" do
    opener = messages(:opener)
    reply = opener.new_reply(users(:john), "Lorem ipsum...")
    reply.save

    email = UserMailer.new_message_posted(reply).deliver

    assert_equal 2, email.bcc.size
    assert email.bcc.include? "avand@avandamiri.com"
    assert email.bcc.include? "krschacht@gmail.com"
  end

  test "new_message_posted doesn't email author" do
    email = UserMailer.new_message_posted(messages(:opener)).deliver
    assert email.bcc.exclude? "avand@avandamiri.com"
  end

  test "charge_failed" do
    user = users(:avand)

    email = UserMailer.charge_failed(user).deliver

    assert_not ActionMailer::Base.deliveries.empty?
    assert_equal ["do-not-reply@nebelscience.com"], email.from
    assert_equal [user.email], email.to
    assert_equal [users(:admin).email], email.bcc
    assert_equal "[Nebel Science] Credit card charge failed.", email.subject
    assert email.body.include? edit_user_url(user, access_token: user.access_token)
  end

end
