class CreateRequisitions < ActiveRecord::Migration
  def change
    create_table :requisitions do |t|
      t.integer :exercise_id
      t.integer :material_id
      t.integer :quantity

      t.timestamps
    end
  end
end
