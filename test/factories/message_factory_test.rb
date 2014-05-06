require "test_helper"

class MessageFactoryTest < ActiveSupport::TestCase

  setup do
    fixture = Rails.root.join "test/fixtures/yahoo_group/message.json"
    @yahoo_group_message = JSON.parse File.read(fixture)
  end

  test "#message initializes author" do
    message = MessageFactory.new(@yahoo_group_message).message

    assert message.author.new_record?
    assert_equal "bernardnebel@verizon.net", message.author.email
    assert_equal "BERNARD%20J NEBEL", message.author.name
  end

  test "#message initializes author with name set to profile" do
    @yahoo_group_message["authorName"] = nil
    message = MessageFactory.new(@yahoo_group_message).message

    assert_equal "bnebel66", message.author.name
  end

  test "#message initializes author with name set to email" do
    @yahoo_group_message["authorName"] = nil
    @yahoo_group_message["profile"] = nil
    message = MessageFactory.new(@yahoo_group_message).message

    assert_equal "bernardnebel@verizon.net", message.author.name
  end

  test "#message finds author" do
    @yahoo_group_message["from"] = "&lt;#{users(:avand).email}&gt;"

    message = MessageFactory.new(@yahoo_group_message).message

    assert_equal message.author, users(:avand)
  end

  test "#message initializes message" do
    message = MessageFactory.new(@yahoo_group_message).message

    assert message.new_record?
    assert_equal "Re: [K5science] RE: Should I purchase a microscope slide making kit?", message.subject
    assert_equal 2740, message.yahoo_group_message_id
    assert_match /\AI am not a fan of kits/, message.body
    assert_match /Bernie Nebel\z/, message.body
    assert_equal Time.at(1383414145), message.created_at
    assert_nil message.messageable
  end

  test "#message sets the subject to 'No Subject' if unavailable" do
    @yahoo_group_message["subject"] = nil

    message = MessageFactory.new(@yahoo_group_message).message

    assert_equal "No Subject", message.subject
  end

  test "#message finds message by Yahoo ID" do
    existing_message = MessageFactory.new(@yahoo_group_message).message
    existing_message.save!

    new_message = MessageFactory.new(@yahoo_group_message).message

    assert_equal existing_message, new_message
  end

  test "#message initializes reply" do
    opener      = Message.create! author: users(:avand), subject: "...", yahoo_group_message_id: 2735
    new_message = MessageFactory.new(@yahoo_group_message).message

    assert_equal new_message.messageable, opener
  end

end
