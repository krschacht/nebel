class Topic < ActiveRecord::Base
  validates_presence_of :name, :subject_id, :order
  validates_uniqueness_of :code

  belongs_to :subject
  has_many :exercises
end
