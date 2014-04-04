class AddYahooMessageIdToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :yahoo_message_id, :integer
    add_index :messages, :yahoo_message_id
  end
end
