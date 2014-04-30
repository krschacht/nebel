class Completion < ActiveRecord::Base
  validates_presence_of :user_id, :topic_id
end
