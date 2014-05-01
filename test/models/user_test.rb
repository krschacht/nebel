require "test_helper"

class UserTest < ActiveSupport::TestCase

  test "validates presence of name" do
    user = User.new
    assert !user.valid?
    assert user.errors[:name].include? "can't be blank"
  end

  test "validates presence of email" do
    user = User.new
    assert !user.valid?
    assert user.errors[:email].include? "can't be blank"
  end

  test "validates presence of password_hash" do
    user = User.new
    assert !user.valid?
    assert user.errors[:password_hash].include? "can't be blank"
  end

  test "validates presence of access_token" do
    user = User.new
    user.stubs(:access_token).returns(nil)
    assert !user.valid?
    assert user.errors[:access_token].include? "can't be blank"
  end

  test "validates uniqueness of trial_ends_at" do
    user = User.new
    user.stubs(:trial_ends_at).returns(nil)
    assert !user.valid?
    assert user.errors[:trial_ends_at].include? "can't be blank"
  end

  test "validates uniqueness of email" do
    user = users(:avand)
    duplicate_user = User.new email: user.email
    assert !duplicate_user.valid?
    assert duplicate_user.errors[:email].include? "has already been taken"
  end

  test "has many messages" do
    assert users(:avand).messages.include? messages(:opener)
  end

  test "has many completions" do
    assert users(:avand).completions.include? completions(:one)
  end

  test "generates an access_token before validation" do
    user = User.new
    SecureRandom.stubs(:hex).returns("abcd1234")
    user.valid?
    assert_equal "abcd1234", user.access_token
  end

  test "password is nil by default" do
    assert_nil User.new.password
  end

  test "setting the password sets the password_hash" do
    User::Password.expects(:create).with("secret").returns("abcd1234")
    user = User.new password: "secret"
    assert_equal "abcd1234", user.password_hash
  end

  test "password can be compared against unencrypted password" do
    user = User.new password: "secret"
    assert user.password == "secret"
  end

  test "admin is false by default" do
    assert !User.new.admin
  end

  test "::by_email scope finds by email case insensitvely" do
    users = User.by_email("AvAnD@aVaNdAmIrI.CoM")
    assert users.include? users(:avand)
    assert users.exclude? users(:admin)
  end

  test "::admins scope includes admins" do
    users = User.admins
    assert users.include? users(:admin)
    assert users.exclude? users(:avand)
  end

  test "sets trial_ends_at to 30 days from now" do
    user = User.new
    user.valid?
    assert_equal 30.days.from_now.to_i, user.trial_ends_at.to_i
  end

  test "does not set trial_ends_at if already set" do
    user = users(:avand)
    trial_ends_at = 30.days.ago
    user.update_column :trial_ends_at, trial_ends_at
    user.valid?
    assert_equal trial_ends_at, user.trial_ends_at
  end

  test "#stripe_customer returns nil if stripe_customer_id is nil" do
    assert_nil User.new.stripe_customer
  end

  test "#stripe_customer retrieves customer from Stripe API once" do
    Stripe::Customer.expects(:retrieve).with("abc123").returns("stripe-customer").once

    user = User.new(stripe_customer_id: "abc123")

    assert_equal "stripe-customer", user.stripe_customer
    user.stripe_customer
  end

  test "#subscribed? returns true if Stripe customer is not null, has a subscription, and is not deleted" do
    user = User.new
    assert_not user.subscribed?

    user.stubs(:stripe_customer).returns(stub(subscription: nil))
    assert_not user.subscribed?

    user.stubs(:stripe_customer).returns(stub(subscription: stub))
    assert user.subscribed?

    user.stubs(:stripe_customer).returns(stub(subscription: stub, deleted: true))
    assert_not user.subscribed?
  end

end
