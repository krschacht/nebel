require "yahoo_group"

namespace :yahoo_group do
  # To run this rake task on Heroku run:
  #
  #   heroku run rake \"yahoo_group:import[\'...\', 0, 3000]\"
  #
  # You can get the first argument, cookies, from your favorite web inspector.
  # Just visit groups.yahoo.com, login with Keith's account, and look at the
  # network inspector. Find an XHR request and look at the headers and copy the
  # value of the Cookie header.
  task :import, [:id, :cookies, :from, :to] => :environment do |task, args|
    args.with_defaults(from: 0, to: 3_000) # There are ~2,700 total messages

    start_of_import = Time.now
    initial_message_count = Message.count

    yahoo_group = YahooGroup.new(args[:id], args[:cookies])

    yahoo_group.messages(args[:from].to_i, args[:to].to_i) do |yahoo_group_message|
      message = MessageFactory.new(args[:id], yahoo_group_message).message
      new_record = message.new_record?
      message.save!

      puts "#{message.yahoo_group_message_id} - #{message.subject} (#{new_record ? "new" : message.id})"

      sleep rand * 2
    end

    users_created = User.where("created_at > ?", start_of_import).count
    users_updated = User.where("updated_at > ?", start_of_import).count - users_created
    messages_created = Message.count - initial_message_count
    messages_updated = Message.where("updated_at > ?", start_of_import).count - messages_created

    puts "#{users_created} users(s) created, #{users_updated} updated (#{User.count} total)"
    puts "#{messages_created} message(s) created, #{messages_updated} updated (#{Message.count} total)"
  end
end
