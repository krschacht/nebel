class MessageFactory

  def initialize(yahoo_message)
    @yahoo_message = yahoo_message
  end

  def message
    author = User.find_or_initialize_by(email: author_email).tap do |user|
      user.name = author_name
    end

    Message.new({
      author:  author,
      subject: @yahoo_message["subject"],
      body:    @yahoo_message["messageBody"]
    })
  end

private

  def author_name
    @yahoo_message["authorName"] || @yahoo_message["profile"]
  end

  def author_email
    @yahoo_message["from"].gsub(/&(g|l)t;/, "").split.last
  end

end
