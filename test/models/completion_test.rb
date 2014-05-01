require "test_helper"

class CompletionTest < ActiveSupport::TestCase

  test "validates presence of user_id" do
    completion = Completion.new
    assert_not completion.valid?
    assert completion.errors[:user_id].include? "can't be blank"
  end

  test "validates presence of topic_id" do
    completion = Completion.new
    assert_not completion.valid?
    assert completion.errors[:topic_id].include? "can't be blank"
  end

  test "belongs to a user" do
    assert_equal users(:avand), completions(:one).user
  end

  test "belongs to a topic" do
    assert_equal topics(:a2), completions(:one).topic
  end

end
