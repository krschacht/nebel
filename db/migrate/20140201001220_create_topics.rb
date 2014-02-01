class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.integer :subject_id, null: false
      t.string  :name, null: false
      t.integer :order, null: false
      t.text    :overview
    end
  end
end
