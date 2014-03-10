class RemoveMaterialsFromExercises < ActiveRecord::Migration
  def up
    remove_column :exercises, :materials
  end

  def down
    add_column :exercises, :materials, :text
  end
end
