class Message < ActiveRecord::Base
  belongs_to :messageable, polymorphic: true
  belongs_to :author, class_name: "User"

  validates_presence_of :author, :subject
  validates :messageable_type, inclusion: { in: %w(Topic Exercise Message) }, allow_nil: true

  scope :openers,    -> { where(messageable_type: ["Topic", "Exercise", nil]) }
  scope :replies,    -> { where(messageable_type: "Message") }
  scope :opened,     -> { where(opened: true) }
  scope :closed,     -> { where(opened: false) }
  scope :archived,   -> { where(archived: true) }
  scope :unarchived, -> { where(archived: false) }

  scope :hanging,    -> { where(messageable_type: nil) }
  scope :attached,   -> { openers.where("messageable_id IS NOT NULL") }

  def reply?
    messageable_type == "Message"
  end

  def opener?
    messageable_type.nil? || messageable_type == "Topic" || messageable_type == "Exercise"
  end

  def new_reply(author, body)
    raise "won't reply to a reply, please reply to the opener" if self.reply?

    Message.new({
      author_id:        author.id,
      messageable_id:   self.id,
      messageable_type: self.class.name,
      subject:          self.subject,
      body:             body
    })
  end

  def thread
    if reply?
      Message.where(
        "id = ? OR (messageable_id = ? AND messageable_type = ?)",
        messageable_id, messageable_id, messageable_type
      ).order(:created_at)
    else
      Message.where(
        "id = ? OR (messageable_id = ? AND messageable_type = ?)",
        id, id, self.class.name
      ).order(:created_at)
    end
  end

  def replies
    @replies ||= Message.where(messageable_type: "Message", messageable_id: id).order(:created_at)
  end

  def archive!
    update_attribute( :archived, true )
  end

  def close!
    update_attribute( :closed, true )
  end
end
