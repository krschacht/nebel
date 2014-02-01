class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :code, length: 1, null: false
      t.string :name, null: false
      t.text   :description
    end
  end
end
