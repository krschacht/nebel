class RemoveNotNullConstraintOnExercisesName < ActiveRecord::Migration
  def up
    change_column :exercises, :name, :string, null: true
  end

  def down
    change_column :exercises, :name, :string, null: false
  end
end
