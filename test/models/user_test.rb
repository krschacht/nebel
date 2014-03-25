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

  test "validates uniqueness of email" do
    user = users(:avand)
    duplicate_user = User.new email: user.email
    assert !duplicate_user.valid?
    assert duplicate_user.errors[:code].include? "has already been taken"
    end
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

end
