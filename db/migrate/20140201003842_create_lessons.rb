class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.integer :topic_id, null: false
      t.string  :name, null: false
      t.string  :duration
      t.text    :body
      t.timestamps
    end
  end
end
