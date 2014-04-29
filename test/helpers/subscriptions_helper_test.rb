require "test_helper"

class SubscriptionsHelperTest < ActionView::TestCase

  test "#days_until" do
    assert_equal "3 days", days_until(3.days.from_now)
    assert_equal "1 day", days_until(1.day.from_now)
  end

  test "#disabled?" do
    assert_not disabled?(nil)

    user = User.new
    controller.stubs(controller_name: "subscriptions")
    assert_not disabled?(user)

    user = User.new
    controller.stubs(controller_name: "users")
    assert_not disabled?(user)

    controller.stubs(controller_name: "not-subscriptions-or-users")

    user = User.new
    user.stubs(trial_ends_at: 30.days.ago, admin?: false, subscribed?: false)
    assert disabled?(user)

    user = User.new
    user.stubs(trial_ends_at: 30.days.ago, admin?: false, subscribed?: true)
    assert_not disabled?(user)

    user = User.new
    user.stubs(trial_ends_at: 30.days.ago, admin?: true, subscribed?: false)
    assert_not disabled?(user)

    user = User.new
    user.stubs(trial_ends_at: 30.days.ago, admin?: true, subscribed?: true)
    assert_not disabled?(user)

    user = User.new
    user.stubs(trial_ends_at: 30.days.from_now, admin?: false, subscribed?: false)
    assert_not disabled?(user)

    user = User.new
    user.stubs(trial_ends_at: 30.days.from_now, admin?: false, subscribed?: true)
    assert_not disabled?(user)

    user = User.new
    user.stubs(trial_ends_at: 30.days.from_now, admin?: true, subscribed?: false)
    assert_not disabled?(user)

    user = User.new
    user.stubs(trial_ends_at: 30.days.from_now, admin?: true, subscribed?: true)
    assert_not disabled?(user)

  end

end
