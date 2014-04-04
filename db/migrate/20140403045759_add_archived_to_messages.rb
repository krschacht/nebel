class AddArchivedToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :archived, :boolean, null: false, default: false
    add_index :messages, :archived
  end
end
