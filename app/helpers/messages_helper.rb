module MessagesHelper

  def canonical_message_path(message, bookmark = nil)
    bookmark ||= "#message-#{message.id}"

    case message.messageable_type
    when "Topic"
      canonical_topic_path(message.messageable.slug) + bookmark
    when "Exercise"
      canonical_exercise_path(message.messageable.topic.slug, message.messageable.part) + bookmark
    when "Message"
      canonical_message_path(message.messageable, bookmark)
    end
  end

end
