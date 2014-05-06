class RenameYahooMessageIdToYahooGroupMessageId < ActiveRecord::Migration
  def change
    rename_column :messages, :yahoo_message_id, :yahoo_group_message_id
  end
end
