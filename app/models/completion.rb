class Completion < ActiveRecord::Base

  validates_presence_of :user_id, :topic_id

  belongs_to :user
  belongs_to :topic

end
