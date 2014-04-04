class RenameObjectToMessageable < ActiveRecord::Migration
  def change
    rename_column :messages, :object_id, :messageable_id
    rename_column :messages, :object_type, :messageable_type
  end
end
