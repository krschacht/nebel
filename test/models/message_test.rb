require 'test_helper'

class MessageTest < ActiveSupport::TestCase

  test "validates presence of author_id" do
    message = Message.new
    assert !message.valid?
    assert message.errors[:author_id].include? "can't be blank"
  end

  test "validates presence of subject" do
    message = Message.new
    assert !message.valid?
    assert message.errors[:subject].include? "can't be blank"
  end

  test "validates messageable_type is either 'Topic', 'Exercise', or 'Message'" do
    message = Message.new messageable_type: "Topic"
    message.valid?
    assert_empty message.errors[:messageable_type]

    message = Message.new messageable_type: "Exercise"
    message.valid?
    assert_empty message.errors[:messageable_type]

    message = Message.new messageable_type: "Message"
    message.valid?
    assert_empty message.errors[:messageable_type]

    message = Message.new messageable_type: "Material"
    message.valid?
    assert message.errors[:messageable_type].include? "is not included in the list"
  end

  test "opened defaults to true" do
    assert Message.new.opened?
  end

  test "order defaults to 0" do
    assert_equal Message.new.order, 0
  end

  test "archived defaults to false" do
    assert !Message.new.archived
  end

  test "belongs to author" do
    assert_equal users(:avand), messages(:opener).author
  end

  test "belongs to messageable" do
    assert_equal topics(:a2), messages(:opener).messageable
    assert_equal messages(:opener), messages(:reply).messageable
  end

  test ".reply? returns true is messageable_type is 'Message'" do
    assert messages(:reply).reply?
  end

  test ".reply? returns false is messageable_type is not 'Message'" do
    assert !messages(:opener).reply?
  end

  test ".opener? returns true if messageable_type is nil, 'Topic' or 'Exercise'" do
    assert Message.new(messageable_type: nil).opener?
    assert Message.new(messageable_type: "Topic").opener?
    assert Message.new(messageable_type: "Exercise").opener?
    assert !Message.new(messageable_type: "Message").opener?
  end

  test ".new_reply returns a new message as a reply" do
    admin  = users(:admin)
    opener = messages(:opener)
    reply  = opener.new_reply(admin, "Looking into it...")

    assert reply.valid?
    assert_equal reply.messageable_id, opener.id
    assert_equal reply.messageable_type, opener.class.name
    assert_equal reply.author_id, admin.id
    assert_equal reply.subject, opener.subject
    assert_equal reply.body, "Looking into it..."
  end

  test ".new_reply raises an exception if called on a reply" do
    admin = users(:admin)
    reply = messages(:reply)

    assert_raise RuntimeError, "won't reply to a reply, please reply to the opener" do
      reply.new_reply(admin, "Still looking into it...")
    end
  end

  test "#openers returns messages whose messageable_type is 'Topic', 'Exercise', or nil chronologically" do
    opener = Message.create! author: users(:avand), subject: "..."
    openers = Message.openers
    assert openers.include? opener
    assert openers.include? messages(:opener)
    assert openers.exclude? messages(:reply)
  end

  test "#replies returns messages whose messageable_type is 'Message' chronologically" do
    replies = Message.replies
    assert replies.include? messages(:reply)
    assert replies.exclude? messages(:opener)
  end

  test "#opened returns messages whose open is true" do
    opened = Message.opened
    assert opened.include? messages(:opener)
    assert opened.exclude? messages(:closed)
  end

  test "#closed returns messages whose open is false" do
    closed = Message.closed
    assert closed.include? messages(:closed)
    assert closed.exclude? messages(:opener)
  end

  test "#archived returns messages whose archived is true" do
    archived = Message.archived
    assert archived.include? messages(:archived)
    assert archived.exclude? messages(:opener)
  end

  test "#unarchived returns messages whose open is false" do
    unarchived = Message.unarchived
    assert unarchived.include? messages(:opener)
    assert unarchived.exclude? messages(:archived)
  end

  test ".thread returns opener and all replies" do
    opener  = messages(:opener)
    reply_1 = messages(:reply)
    reply_2 = opener.new_reply(opener.author, "Are you sure? Double check.")
    reply_3 = opener.new_reply(users(:admin), "Oh, it's 42!")
    reply_4 = opener.new_reply(opener.author, "That's what I thought, thanks!")

    Message.create!({
      author_id:        users(:avand).id,
      messageable_id:   opener.messageable_id,
      messageable_type: opener.messageable_type,
      subject:          "What's the velocity of an unladen swallow?"
    })

    reply_2.save!
    reply_3.save!
    reply_4.save!

    reply_3.thread.tap do |thread|
      assert_equal 5, thread.size
      assert_equal thread[0], opener
      assert_equal thread[1], reply_1
      assert_equal thread[2], reply_2
      assert_equal thread[3], reply_3
      assert_equal thread[4], reply_4
    end

    opener.thread.tap do |thread|
      assert_equal 5, thread.size
      assert_equal thread[0], opener
      assert_equal thread[1], reply_1
      assert_equal thread[2], reply_2
      assert_equal thread[3], reply_3
      assert_equal thread[4], reply_4
    end
  end

  test "#replies returns replies to a message" do
    opener = messages(:opener)
    reply = messages(:reply)
    Message.create! messageable: topics(:a2), author: opener.author, subject: "..."
    assert_equal 1, opener.replies.size
    assert opener.replies.include? reply
  end

end
