class CreateIndexesOnForeignKeys < ActiveRecord::Migration
  def change
    add_index :lessons, :topic_id
    add_index :topics,  :subject_id
  end
end
