require "test_helper"

class WebhooksControllerTest < ActionController::TestCase

  test "POST to stripe handles a charge failed event for a user" do
    user = users(:avand)
    user.update_attribute :stripe_customer_id, "cus_11111111111111"

    charge = stub(customer: "cus_11111111111111")
    data   = stub(object: charge)
    event  = stub(livemode: true, type: "charge.failed", data: data)

    Stripe::Event.expects(:retrieve).with("evt_00000000000000").returns(event)

    post :stripe, id: "evt_00000000000000"

    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_response :success
  end

  test "POST to stripe does nothing if the livemode is false" do
    event = stub(livemode: false)

    Stripe::Event.expects(:retrieve).with("evt_00000000000000").returns(event)

    post :stripe, id: "evt_00000000000000"

    assert_equal 0, ActionMailer::Base.deliveries.size
    assert_response :success
  end

end
