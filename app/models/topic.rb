class Topic < ActiveRecord::Base
  validates_presence_of :name, :subject_id, :order, :code, :slug
  validates_uniqueness_of :code, :slug

  belongs_to :subject
  has_many :exercises
  has_many :prerequisites
  has_many :prerequisite_topics, through: :prerequisites, after_add: :update_all_prerequisite_topic_ids, after_remove: :update_all_prerequisite_topic_ids
  has_many :subsequents, class_name: "Prerequisite", foreign_key: "prerequisite_topic_id"
  has_many :subsequent_topics, through: :subsequents, source: :topic
  has_many :messages, as: :messageable
  has_many :completions

  before_validation :generate_slug, if: :code

  def next(limit = 1)
    subject.topics.order(:order).where("topics.order > ?", order).limit(limit)
  end

  def previous(limit = 1)
    subject.topics.order("topics.order DESC").where("topics.order < ?", order).limit(limit).reverse
  end

  def all_prerequisite_topic_ids
    super.map(&:to_i)
  end

  def self.update_all_prerequisite_topic_ids
    all_prerequisites = Prerequisite.all

    Topic.all.each do |topic|
      all_prerequisite_topic_ids = Prerequisite.all_prerequisite_topic_ids_for_topic_id topic.id, all_prerequisites
      topic.update_attribute :all_prerequisite_topic_ids, all_prerequisite_topic_ids
    end
  end

private

  def generate_slug
    write_attribute(:slug, TopicSlug.new(code).slug)
  end

  def update_all_prerequisite_topic_ids(prerequisite_topic)
    self.class.update_all_prerequisite_topic_ids
  end

end
