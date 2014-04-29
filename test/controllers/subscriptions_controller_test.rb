require "test_helper"

class SubscriptionsControllerTest < ActionController::TestCase

  test "GET to new requires a user" do
    get :new

    assert_user_required
  end

  test "GET to new renders new" do
    login_as_user

    get :new

    assert_response :success
    assert_template :new
    assert_select ".trial-message", "You have 30 days left in your trial."
  end

  test "POST to create requires a user" do
    post :create

    assert_user_required
  end

  test "POST to create creates Stripe customer on 'basic' plan" do
    login_as_user

    Stripe::Customer.expects(:create).with({
      email:     current_user.email,
      card:      "abc123",
      plan:      "basic",
      trial_end: current_user.trial_ends_at.to_i
    }).returns(stub(id: "xyz789"))

    post :create, stripeToken: "abc123"
  end

  test "POST to create creates Stripe customer with trial_end as 'now'" do
    login_as_user

    current_user.update_attribute :trial_ends_at, 30.days.ago

    Stripe::Customer.expects(:create)
      .with(has_entry(:trial_end, "now"))
      .returns(stub(id: "xyz789"))

    post :create
  end

  test "POST to create updates current_user with Stripe customer ID" do
    login_as_user

    Stripe::Customer.stubs(:create).returns(stub(id: "xyz789"))

    post :create

    assert_equal current_user.reload.stripe_customer_id, "xyz789"
    assert_select ".trial-message", false
  end

  test "POST to create redirects to edit_user_path for current user" do
    login_as_user

    Stripe::Customer.stubs(:create).returns(stub(id: "xyz789"))

    post :create

    assert_redirected_to edit_user_path(current_user)
    assert_equal flash[:notice], "You are now subscribed!"
  end

  test "PATCH to update requires a user" do
    patch :update

    assert_user_required
  end

  test "PATCH to update updates the subscription of the Stripe customer" do
    login_as_user

    stripe_customer = mock()
    stripe_customer.expects(:update_subscription).with card: "abc123", plan: "basic"
    User.any_instance.expects(:stripe_customer).returns(stripe_customer)

    patch :update, stripeToken: "abc123"
  end

  test "PATCH to update redirects to edit_user_path for current_user" do
    login_as_user

    User.any_instance.stubs(:stripe_customer).returns(stub(:update_subscription))

    patch :update

    assert_redirected_to edit_user_path(current_user)
    assert_equal flash[:notice], "Your card has been updated!"
  end

  test "DELETE to destroy requires a user" do
    delete :destroy

    assert_user_required
  end

  test "DELETE to destroy cancels the user's Stripe subscription" do
    login_as_user

    stripe_customer = mock()
    stripe_customer.expects(:cancel_subscription)
    User.any_instance.expects(:stripe_customer).returns(stripe_customer)

    delete :destroy
  end

  test "DELETE to destroy redirects to edit_user_path for current_user" do
    login_as_user

    User.any_instance.stubs(:stripe_customer).returns(stub(:cancel_subscription))

    delete :destroy

    assert_redirected_to edit_user_path(current_user)
    assert_equal "Your subscription has been cancelled.", flash[:notice]
  end

end
