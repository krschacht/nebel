class AddMaterialsTextToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :materials_text, :text
  end
end
