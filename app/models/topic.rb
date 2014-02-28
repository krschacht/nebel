class Topic < ActiveRecord::Base
  validates_presence_of :name, :subject_id, :order
  validates_uniqueness_of :code

  belongs_to :subject
  has_many :exercises
  has_many :prerequisites
  has_many :prerequisite_topics, through: :prerequisites
  has_many :subsequents, class_name: "Prerequisite", foreign_key: "prerequisite_topic_id"
  has_many :subsequent_topics, through: :subsequents, source: :topic
end
