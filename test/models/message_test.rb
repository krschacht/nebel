require 'test_helper'

class MessageTest < ActiveSupport::TestCase

  test "validates presence of author_id" do
    message = Message.new
    assert !message.valid?
    assert message.errors[:author_id].include? "can't be blank"
  end

  test "validates presence of object_id" do
    message = Message.new
    assert !message.valid?
    assert message.errors[:object_id].include? "can't be blank"
  end

  test "validates presence of object_type" do
    message = Message.new
    assert !message.valid?
    assert message.errors[:object_type].include? "can't be blank"
  end

  test "validates presence of subject" do
    message = Message.new
    assert !message.valid?
    assert message.errors[:subject].include? "can't be blank"
  end

  test "open defaults to true" do
    assert Message.new.open
  end

  test "order defaults to 0" do
    assert_equal Message.new.order, 0
  end

end
