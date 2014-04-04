require "test_helper"

class MessageFactoryTest < ActiveSupport::TestCase

  setup do
    fixture = Rails.root.join "test/fixtures/yahoo_group/message.json"
    @yahoo_message = JSON.parse File.read(fixture)
  end

  test "#message initializes author" do
    message = MessageFactory.new(@yahoo_message).message

    assert message.author.new_record?
    assert_equal "bernardnebel@verizon.net", message.author.email
    assert_equal "BERNARD%20J NEBEL", message.author.name
  end

  test "#message finds author" do
    @yahoo_message["from"] = "&lt;#{users(:avand).email}&gt;"

    message = MessageFactory.new(@yahoo_message).message

    assert_equal message.author, users(:avand)
  end

  test "#message initializes message" do
    message = MessageFactory.new(@yahoo_message).message

    assert message.new_record?
    assert_equal "Re: [K5science] RE: Should I purchase a microscope slide making kit?", message.subject
    assert message.body.include? "you need for making slides"
  end

end
