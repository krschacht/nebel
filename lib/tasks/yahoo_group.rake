require "yahoo_group"

namespace :yahoo_group do
  task :import, [:cookies, :offset, :limit] => :environment do |task, args|
    args.with_defaults(offset: 0, limit: YahooGroup::LIMIT)

    start_of_import = Time.now
    initial_message_count = Message.count

    yahoo_group = YahooGroup.new(args[:cookies])

    yahoo_group.messages(args[:offset].to_i, args[:limit].to_i) do |yahoo_message|
      message = MessageFactory.new(yahoo_message).message
      new_record = message.new_record?
      message.save!

      puts "#{message.yahoo_message_id} - #{message.subject} (#{new_record ? "new" : message.id})"
    end

    puts "#{User.where("created_at > ?", start_of_import).count} users(s) created, #{User.where("updated_at > ?", start_of_import).count} updated (#{User.count} total)"
    puts "#{Message.count - initial_message_count} message(s) created, #{Message.where("updated_at > ?", start_of_import).count} updated (#{Message.count} total)"
  end
end
