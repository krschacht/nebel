class Topic < ActiveRecord::Base
  validates_presence_of :name, :subject_id, :order

  belongs_to :subject
  has_many :lessons
end
