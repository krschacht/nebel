class Lesson < ActiveRecord::Base
  validates_presence_of :name

  belongs_to :topic
end
