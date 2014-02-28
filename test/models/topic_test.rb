require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  test "validates presence of name" do
    topic = Topic.new
    assert !topic.valid?
    assert topic.errors[:name].include? "can't be blank"
  end

  test "validates presence of subject_id" do
    topic = Topic.new
    assert !topic.valid?
    assert topic.errors[:subject_id].include? "can't be blank"
  end

  test "validates uniqueness of code" do
    topic = topics(:a3)
    duplicate_topic = Topic.new code: topic.code
    assert !duplicate_topic.valid?
    assert duplicate_topic.errors[:code].include? "has already been taken"
  end

  test "belongs to a subject" do
    assert_equal topics(:a3).subject, subjects(:a)
  end
end
