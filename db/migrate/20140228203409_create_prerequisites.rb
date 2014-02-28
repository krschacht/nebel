class CreatePrerequisites < ActiveRecord::Migration
  def change
    create_table :prerequisites do |t|
      t.integer :topic_id
      t.integer :prerequisite_topic_id
    end
  end
end
