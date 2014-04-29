require 'test_helper'

class MessagesHelperTest < ActionView::TestCase

  test "#canonical_message_path returns canonical topic path if message's messable is a Topic" do
    opener = messages(:opener)

    assert_equal \
      canonical_topic_path(opener.messageable.slug, anchor: "message-#{opener.id}"),
      canonical_message_path(opener)
  end

  test "#canonical_message_path returns canonical topic path if message's messageable is an Exercise" do
    opener = messages(:opener)
    opener.messageable = exercises(:d5_part1)

    assert_equal \
      canonical_topic_path(opener.messageable.topic.slug, anchor: "message-#{opener.id}"),
      canonical_message_path(opener)
  end

  test "#canonical_message_path returns path of opener message if message's messageable is a Message" do
    reply = messages(:reply)

    assert_equal \
      canonical_topic_path(reply.messageable.messageable.slug, anchor: "message-#{reply.id}"),
      canonical_message_path(reply)
  end

  test "#canonical_message_path returns message_path of message if message's messageable is nil" do
    message = users(:avand).messages.create! subject: "foo"

    assert_equal message_path(message, anchor: "message-#{message.id}"), canonical_message_path(message)
  end

end
