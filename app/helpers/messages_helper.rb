module MessagesHelper

  def canonical_message_path(message, bookmark = nil)
    bookmark ||= "#message-#{message.id}"

    case message.object_type
    when "Topic"
      canonical_topic_path(message.object.slug) + bookmark
    when "Exercise"
      canonical_exercise_path(message.object.topic.slug, message.object.part) + bookmark
    when "Message"
      canonical_message_path(message.object, bookmark)
    end
  end

end
