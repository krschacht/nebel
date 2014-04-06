class Exercise < ActiveRecord::Base
  validates_presence_of :topic_id, :part

  belongs_to :topic
  has_many :requisitions
  has_many :materials, -> { order("archived") }, through: :requisitions
  has_many :messages, as: :messageable

  def name
    read_attribute(:name) || "Part #{part}"
  end
end
