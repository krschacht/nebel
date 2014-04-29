module MessagesHelper

  def canonical_message_path(message, anchor = nil)
    anchor ||= "message-#{message.id}"

    case message.messageable_type
    when "Topic"
      canonical_topic_path(message.messageable.slug, anchor: anchor)
    when "Exercise"
      canonical_topic_path(message.messageable.topic.slug, anchor: anchor)
    when "Message"
      canonical_message_path(message.messageable, anchor)
    else
      message_path(message, anchor: anchor)
    end
  end

end
