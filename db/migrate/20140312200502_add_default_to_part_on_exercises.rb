class AddDefaultToPartOnExercises < ActiveRecord::Migration
  def change
    change_column :exercises, :part, :integer, default: 1, null: false
  end
end
