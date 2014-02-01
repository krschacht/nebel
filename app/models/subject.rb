class Subject < ActiveRecord::Base
  validates_presence_of :code, :name

  has_many :topics
end
