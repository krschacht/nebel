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
      message.author = author
      message.subject = @yahoo_message["subject"]
      message.body = message_body
      message.created_at = message_created_at
    end
  end

private

  def author_name
    @yahoo_message["authorName"] || @yahoo_message["profile"]
  end

  def author_email
    @yahoo_message["from"].gsub(/&(g|l)t;/, "").split.last
  end

  def message_body
    body = @yahoo_message["messageBody"]
    body = ReverseMarkdown.convert body
    body.gsub(/^>.*/, "").clean
  end

  def message_created_at
    Time.at(@yahoo_message["postDate"].to_i)
  end

end
