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
    assert !user.valid?
    assert user.errors[:access_token].include? "can't be blank"
  end

end
