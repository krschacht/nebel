class Prerequisite < ActiveRecord::Base
  belongs_to :topic
  belongs_to :prerequisite_topic, class_name: "Topic"
end
