class ChangeExerciseDurationToText < ActiveRecord::Migration
  def change
    change_column :exercises, :duration, :text
  end
end
