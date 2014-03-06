class RenameContextToProgression < ActiveRecord::Migration
  def change
    rename_column :topics, :context, :progression
  end
end
