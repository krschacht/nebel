require "test_helper"

class SubscriptionsHelperTest < ActionView::TestCase

  test "#days_until" do
    assert_equal "3 days", days_until(3.days.from_now)
    assert_equal "1 day", days_until(1.day.from_now)
  end

end
