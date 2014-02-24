class AddColumnsToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :context, :text
    add_column :topics, :objectives, :text
    add_column :topics, :teachable_moments, :text
    add_column :topics, :questions, :text
    add_column :topics, :parents, :text
    add_column :topics, :connections, :text
    add_column :topics, :books, :text
  end
end
