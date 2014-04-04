class RenameOpenToOpenedOnMessages < ActiveRecord::Migration
  def change
    rename_column :messages, :open, :opened
  end
end
