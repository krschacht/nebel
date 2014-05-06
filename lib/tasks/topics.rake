namespace :topics do
  task update_all_prerequisite_topic_ids: :environment do
    Topic.update_all_prerequisite_topic_ids
  end
end
