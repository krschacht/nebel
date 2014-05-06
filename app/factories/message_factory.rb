class MessageFactory

  def initialize(yahoo_group_id, yahoo_group_message)
    @yahoo_group_id, @yahoo_group_message = yahoo_group_id, yahoo_group_message
  end

  def message
    author = User.find_or_initialize_by(email: author_email).tap do |user|
      user.name = author_name
      user.password = "something" if user.new_record?
    end

    params = { yahoo_group_id: @yahoo_group_id, yahoo_group_message_id: @yahoo_group_message["msgId"] }

    Message.find_or_initialize_by(params).tap do |message|
      message.author     = author
      message.subject    = message_subject
      message.body       = message_body
      message.created_at = message_created_at

      if reply?
        message.messageable = Message.find_by({
          yahoo_group_id: @yahoo_group_id,
          yahoo_group_message_id: @yahoo_group_message["topicId"]
        })
      end
    end
  end

private

  def author_name
    return @yahoo_group_message["authorName"] if @yahoo_group_message["authorName"].present?
    return @yahoo_group_message["profile"]    if @yahoo_group_message["profile"].present?
    author_email
  end

  def author_email
    @author_email ||= @yahoo_group_message["from"].gsub(/&(g|l)t;/, "").split.last
  end

  def message_body
    body = @yahoo_group_message["messageBody"]
    body = ReverseMarkdown.convert body
    body.gsub(/^>.*/, "").gsub(/^--- In.*/, "").clean
  end

  def message_created_at
    Time.at(@yahoo_group_message["postDate"].to_i)
  end

  def reply?
    @yahoo_group_message["topicId"] != @yahoo_group_message["msgId"]
  end

  def message_subject
    @yahoo_group_message["subject"] || "No Subject"
  end

end
