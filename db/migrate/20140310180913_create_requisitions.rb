class CreateRequisitions < ActiveRecord::Migration
  def change
    create_table :requisitions do |t|
      t.integer :exercise_id
      t.integer :material_id
      t.integer :quantity, default: 1

      t.timestamps
    end
  end
end
