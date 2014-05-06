class AddYahooGroupToMessages < ActiveRecord::Migration
  def up
    add_column :messages, :yahoo_group_id, :string
    add_index :messages, :yahoo_group_id

    Message.reset_column_information

    Message.update_all yahoo_group_id: "K5science"
  end

  def down
    remove_column :messages, :yahoo_group_id
  end
end
