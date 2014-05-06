class Prerequisite < ActiveRecord::Base
  belongs_to :topic
  belongs_to :prerequisite_topic, class_name: "Topic"

  def self.all_prerequisite_topic_ids_for_topic_id(topic_id, all = nil, excluded_topic_ids = [])
    prerequisites              = all || self.all
    topic_prerequisites        = prerequisites.select { |p| p.topic_id == topic_id }
    all_prerequisite_topic_ids = topic_prerequisites.map(&:prerequisite_topic_id)

    topic_prerequisites.each do |prerequisite|
      topic_id              = prerequisite.topic_id
      prerequisite_topic_id = prerequisite.prerequisite_topic_id

      all_prerequisite_topic_ids << prerequisite_topic_id

      if excluded_topic_ids.exclude?(prerequisite.topic_id)
        excluded_topic_ids << prerequisite.topic_id
        all_prerequisite_topic_ids += all_prerequisite_topic_ids_for_topic_id(
          prerequisite_topic_id, prerequisites, excluded_topic_ids)
      end
    end

    all_prerequisite_topic_ids.uniq
  end
end
