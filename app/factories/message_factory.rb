class MessageFactory

  def initialize(yahoo_message)
    @yahoo_message = yahoo_message
  end

  def message
    author = User.find_or_initialize_by(email: email).tap do |user|
      user.name = @yahoo_message["authorName"]
    end

    Message.new({
      author:  author,
      subject: @yahoo_message["subject"],
      body:    @yahoo_message["messageBody"]
    })
  end

private

  def email
    @yahoo_message["from"].gsub(/&(g|l)t;/, "").split.last
  end

end
