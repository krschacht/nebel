class MessageFactory

  def initialize(yahoo_message)
    @yahoo_message = yahoo_message
  end

  def message
    author = User.find_or_initialize_by(email: author_email).tap do |user|
      user.name = author_name
    end

    if author.new_record?
      author.password = "something"
    end

    Message.find_or_initialize_by(yahoo_message_id: @yahoo_message["msgId"]).tap do |message|
      message.author     = author
      message.subject    = message_subject
      message.body       = message_body
      message.created_at = message_created_at

      if reply?
        reply = Message.find_by yahoo_message_id: @yahoo_message["topicId"]
        message.messageable = reply
      end
    end
  end

private

  def author_name
    return @yahoo_message["authorName"] if @yahoo_message["authorName"].present?
    return @yahoo_message["profile"]    if @yahoo_message["profile"].present?
    author_email
  end

  def author_email
    @author_email ||= @yahoo_message["from"].gsub(/&(g|l)t;/, "").split.last
  end

  def message_body
    body = @yahoo_message["messageBody"]
    body = ReverseMarkdown.convert body
    body.gsub(/^>.*/, "").gsub(/^--- In.*/, "").clean
  end

  def message_created_at
    Time.at(@yahoo_message["postDate"].to_i)
  end

  def reply?
    @yahoo_message["topicId"] != @yahoo_message["msgId"]
  end

  def message_subject
    @yahoo_message["subject"] || "No Subject"
  end

end
