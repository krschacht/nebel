require "book_importer"

namespace :book do
  task :import, [:path] => :environment do |task, args|
    Topic.delete_all
    Exercise.delete_all
    book_importer = BookImporter.new(Dir[args[:path]])
    book_importer.import
    puts "#{Topic.count} topic(s) created"
    puts "#{Exercise.count} exercise(s) created"
  end
end
