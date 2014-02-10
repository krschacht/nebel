class RenameLessonsToExercises < ActiveRecord::Migration
  def change
    rename_table :lessons, :exercises
  end
end
