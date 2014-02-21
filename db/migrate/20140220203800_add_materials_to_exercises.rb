class AddMaterialsToExercises < ActiveRecord::Migration
  def change
    add_column :exercises, :materials, :text
  end
end
