class RemoveNotNullConstraintOnMessagesMessageableColumns < ActiveRecord::Migration
  def up
    change_column :messages, :messageable_id, :integer, null: true
    change_column :messages, :messageable_type, :string, null: true
  end

  def down
    change_column :messages, :messageable_id, :integer, null: false
    change_column :messages, :messageable_type, :string, null: false
  end
end
