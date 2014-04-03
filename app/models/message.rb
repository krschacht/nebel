class Message < ActiveRecord::Base
  belongs_to :object, polymorphic: true
  belongs_to :author, class_name: "User"

  validates_presence_of :author_id, :object_id, :object_type, :subject
  validates :object_type, inclusion: { in: %w(Topic Exercise Message) }

  scope :openers,    -> { where(object_type: %w(Topic Exercise)) }
  scope :replies,    -> { where(object_type: "Message") }
  scope :opened,     -> { where(open: true) }
  scope :closed,     -> { where(open: false) }
  scope :archived,   -> { where(archived: true) }
  scope :unarchived, -> { where(archived: false) }

  def reply?
    object_type == "Message"
  end

  def opener?
    object_type == "Topic" || object_type == "Exercise"
  end

  def new_reply(author, body)
    raise "won't reply to a reply, please reply to the opener" if self.reply?

    Message.new({
      author_id:   author.id,
      object_id:   self.id,
      object_type: self.class.name,
      subject:     self.subject,
      body:        body
    })
  end

  def thread
    if reply?
      Message.where(
        "id = ? OR (object_id = ? AND object_type = ?)",
        object_id, object_id, object_type
      ).order(:created_at)
    else
      Message.where(
        "id = ? OR (object_id = ? AND object_type = ?)",
        id, id, self.class.name
      ).order(:created_at)
    end
  end

  def replies
    @replies ||= Message.where(object_type: "Message", object_id: id).order(:created_at)
  end
end
