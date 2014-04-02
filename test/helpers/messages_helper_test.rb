require 'test_helper'

class MessagesHelperTest < ActionView::TestCase

  test "#canonical_message_path returns canonical topic path if message's object is a Topic" do
    opener = messages(:opener)

    assert_equal \
      canonical_topic_path(opener.object.slug) + "#message-#{opener.id}",
      canonical_message_path(opener)
  end

  test "#canonical_message_path returns canonical exercise path if message's object is an Exercise" do
    opener = messages(:opener)
    opener.object = exercises(:d5_part1)

    assert_equal \
      canonical_exercise_path(opener.object.topic.slug, opener.object.part) + "#message-#{opener.id}",
      canonical_message_path(opener)
  end

  test "#canonical_message_path returns path of opener message if message's object is a Message" do
    reply = messages(:reply)

    assert_equal \
      canonical_topic_path(reply.object.object.slug) + "#message-#{reply.id}",
      canonical_message_path(reply)
  end

end
