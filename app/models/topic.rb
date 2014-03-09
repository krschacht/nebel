class Topic < ActiveRecord::Base
  validates_presence_of :name, :subject_id, :order, :code, :slug
  validates_uniqueness_of :code, :slug

  belongs_to :subject
  has_many :exercises
  has_many :prerequisites
  has_many :prerequisite_topics, through: :prerequisites
  has_many :subsequents, class_name: "Prerequisite", foreign_key: "prerequisite_topic_id"
  has_many :subsequent_topics, through: :subsequents, source: :topic

  before_validation :generate_slug, if: :code

private

  def generate_slug
    slug = code.downcase.gsub("/", "")
    write_attribute(:slug, slug)
  end

end
