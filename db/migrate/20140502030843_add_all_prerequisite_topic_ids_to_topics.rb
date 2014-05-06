class AddAllPrerequisiteTopicIdsToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :all_prerequisite_topic_ids, :string, array: true, default: []
  end
end
