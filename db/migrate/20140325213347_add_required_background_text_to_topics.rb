class AddRequiredBackgroundTextToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :required_background_text, :text
  end
end
