class CreateIndexes < ActiveRecord::Migration
  def change
    add_index :exercises, :part
    add_index :exercises, :created_at
    add_index :exercises, :updated_at

    add_index :materials, :archived
    add_index :materials, :created_at
    add_index :materials, :updated_at

    add_index :prerequisites, :topic_id

    add_index :requisitions, :exercise_id
    add_index :requisitions, :material_id
    add_index :requisitions, :quantity
    add_index :requisitions, :created_at
    add_index :requisitions, :updated_at

    add_index :topics, :order
    add_index :topics, :created_at
    add_index :topics, :updated_at

    add_index :users, :created_at
    add_index :users, :updated_at
  end
end
