class DropDurationFromExercises < ActiveRecord::Migration
  def up
    remove_column :exercises, :duration
  end

  def down
    add_column :exercises, :duration, :text
  end
end
