class Exercise < ActiveRecord::Base
  validates_presence_of :topic_id, :part

  belongs_to :topic
  has_many :requisitions
  has_many :materials, through: :requisitions
  has_many :messages, as: :object

  def name
    read_attribute(:name) || "Part #{part}"
  end
end
