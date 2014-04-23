class Topic < ActiveRecord::Base
  validates_presence_of :name, :subject_id, :order, :code, :slug
  validates_uniqueness_of :code, :slug

  belongs_to :subject
  has_many :exercises
  has_many :prerequisites
  has_many :prerequisite_topics, through: :prerequisites
  has_many :subsequents, class_name: "Prerequisite", foreign_key: "prerequisite_topic_id"
  has_many :subsequent_topics, through: :subsequents, source: :topic
  has_many :messages, as: :messageable

  before_validation :generate_slug, if: :code

  def next(limit = 1)
    subject.topics.order(:order).where("topics.order > ?", order).limit(limit)
  end

  def previous(limit = 1)
    subject.topics.order("topics.order DESC").where("topics.order < ?", order).limit(limit).reverse
  end

private

  def generate_slug
    slug = code.downcase.gsub("/", "")
    write_attribute(:slug, slug)
  end

end
