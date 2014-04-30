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

end
