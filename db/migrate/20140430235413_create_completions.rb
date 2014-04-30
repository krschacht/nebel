class CreateCompletions < ActiveRecord::Migration
  def change
    create_table :completions do |t|
      t.integer :user_id, null: false
      t.integer :topic_id, null: false
      t.timestamps
    end
  end
end
