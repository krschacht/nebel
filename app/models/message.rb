class Message < ActiveRecord::Base
  belongs_to :object, polymorphic: true

  validates_presence_of :author_id, :object_id, :object_type, :subject
end
