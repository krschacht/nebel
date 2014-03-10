class Exercise < ActiveRecord::Base
  validates_presence_of :name, :topic_id

  belongs_to :topic
  has_many :requisitions
  has_many :materials, through: :requisitions
end
