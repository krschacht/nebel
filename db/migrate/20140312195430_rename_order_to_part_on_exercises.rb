class RenameOrderToPartOnExercises < ActiveRecord::Migration
  def change
    rename_column :exercises, :order, :part
  end
end
