require "book_importer"
require "open-uri"
require "zip"
require "fileutils"

namespace :book do
  task :download_and_import, [:url] => [:download, :import]

  # Given a path to lessons in plain text format, this task will create topics
  # and exercises. It deletes all topics and exercises first. The default path
  # is all text files inside "tmp/book".
  #
  # Examples:
  #
  #   rake book:import
  #   rake book:import["path/to/lessons/**/*.txt"]
  task :import, [:path] => :environment do |task, args|
    args.with_defaults path: Rails.root.join("tmp/book/**/*.txt")

    start_of_import = Time.now

    book_importer = BookImporter.new(Dir[args[:path]])
    book_importer.import

    puts "#{Topic.where("created_at > ?", start_of_import).count} topic(s) created (#{Topic.count} total)"
    puts "#{Exercise.where("created_at > ?", start_of_import).count} exercise(s) created (#{Exercise.count} total)"
    puts "#{Material.where("created_at > ?", start_of_import).count} material(s) created (#{Material.count} total)"
    puts "#{Requisition.where("created_at > ?", start_of_import).count} requisition(s) created (#{Requisition.count} total)"
  end

  # Given an URL to a ZIP of plain text files, this task will download the ZIP,
  # extract the contents, and save the results in "tmp/book".
  #
  # Example:
  #
  #   rake book:download["https://dl.dropboxusercontent.com/u/1062541/BFSU.zip"]
  task :download, [:url] => :environment do |task, args|
    tmp_dir = Rails.root.join("tmp/book")
    tmp_zip = tmp_dir.join("lessons.zip")

    FileUtils.rm_rf(tmp_dir) and Dir.mkdir(tmp_dir)

    File.open(tmp_zip, "wb") do |saved_file|
      open(args[:url], "rb") do |read_file|
        saved_file.write(read_file.read)
      end
    end

    Zip::File.new(tmp_zip).each do |entry|
      entry.get_input_stream do |stream|
        if stream.is_a?(Zip::InputStream) && !entry.name.match(/MACOSX/)
          lesson_path = tmp_dir.join(entry.name)
          lesson_dir  = lesson_path.to_s.gsub(/\/[a-z\d]+\.txt$/, "")

          FileUtils.mkdir_p(lesson_dir) unless Dir.exists?(lesson_dir)

          File.open(lesson_path, "w") do |file|
            file.write stream.read.force_encoding("UTF-8")
          end
        end
      end
    end

    File.delete(tmp_zip)
  end
end
