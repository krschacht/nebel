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

  test "validates presence of order" do
    topic = Topic.new
    assert !topic.valid?
    assert topic.errors[:order].include? "can't be blank"
  end

  test "validates presence of code" do
    topic = Topic.new
    assert !topic.valid?
    assert topic.errors[:code].include? "can't be blank"
  end

  test "validates presence of slug" do
    topic = Topic.new
    assert !topic.valid?
    assert topic.errors[:slug].include? "can't be blank"
  end

  test "validates uniqueness of code" do
    topic = topics(:a3)
    duplicate_topic = Topic.new code: topic.code
    assert !duplicate_topic.valid?
    assert duplicate_topic.errors[:code].include? "has already been taken"
  end

  test "validates uniqueness of slug" do
    topic = topics(:a3)
    duplicate_topic = Topic.new slug: topic.slug
    assert !duplicate_topic.valid?
    assert duplicate_topic.errors[:slug].include? "has already been taken"
  end

  test "belongs to a subject" do
    assert_equal topics(:a3).subject, subjects(:a)
  end

  test "has many prerequisite topics" do
    prerequisite_topic = topics(:a2)
    subsequent_topic   = topics(:a3)

    subsequent_topic.prerequisite_topics << prerequisite_topic

    assert subsequent_topic.reload.prerequisite_topics.include? prerequisite_topic
    assert prerequisite_topic.reload.subsequent_topics.include? subsequent_topic
  end

  test "has many subsequent topics" do
    prerequisite_topic = topics(:a2)
    subsequent_topic   = topics(:a3)

    prerequisite_topic.subsequent_topics << subsequent_topic

    assert prerequisite_topic.reload.subsequent_topics.include? subsequent_topic
    assert subsequent_topic.reload.prerequisite_topics.include? prerequisite_topic
  end

  test "has many messages" do
    assert topics(:a2).messages.include? messages(:opener)
  end

  test "has many completions" do
    assert topics(:a2).completions.include? completions(:one)
  end

  test "generates slug from code automatically" do
    topic = Topic.new code: "A-3"
    topic.valid?
    assert_equal "a-3", topic.slug

    topic = Topic.new code: "A/B-1"
    topic.valid?
    assert_equal "ab-1", topic.slug

    topic = Topic.new code: "D-9B"
    topic.valid?
    assert_equal "d-9b", topic.slug
  end

  test "updates all_prerequisite_topic_ids for all topics when a prerequisite is added or removed" do
    topic_a, topic_b, topic_c = topics(:a2), topics(:a3), topics(:d5)

    topic_b.prerequisite_topics << topic_a
    topic_c.prerequisite_topics << topic_b

    assert_equal [topic_a.id], topic_b.reload.all_prerequisite_topic_ids
    assert_equal [topic_b.id, topic_a.id], topic_c.reload.all_prerequisite_topic_ids

    topic_b.prerequisite_topics.delete(topic_a)

    assert_equal [], topic_b.reload.all_prerequisite_topic_ids
    assert_equal [topic_b.id], topic_c.reload.all_prerequisite_topic_ids
  end

  test "#all_prerequisite_topic_ids is an empty array by default" do
    assert_equal [], Topic.new.all_prerequisite_topic_ids
  end

  test "#all_prerequisite_topic_ids always returns an array of numbers" do
    assert_equal [1, 2, 3], Topic.new(all_prerequisite_topic_ids: %w(1 2 3)).all_prerequisite_topic_ids
  end

  test "#next" do
    topic = topics(:a2)
    next_topics = topic.next
    assert_equal [topics(:a3)], next_topics
  end

  test "#previous" do
    topic = topics(:a3)
    previous_topics = topic.previous
    assert_equal [topics(:a2)], previous_topics
  end

end
