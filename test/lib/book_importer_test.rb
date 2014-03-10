require "test_helper"
require "book_importer"

class BookImporterTest < ActiveSupport::TestCase

  test "#import" do
    beginning_of_test = Time.now
    lesson_paths      = Rails.root.join "test/fixtures/lesson_samples/**/*.txt"
    book_importer     = BookImporter.new Dir[lesson_paths]

    book_importer.import

    topics       = Topic.where("created_at > ?", beginning_of_test)
    exercises    = Exercise.where("created_at > ?", beginning_of_test)
    materials    = Material.where("created_at > ?", beginning_of_test)
    requisitions = Requisition.where("created_at > ?", beginning_of_test)

    assert_equal 9, topics.count
    assert_equal 26, exercises.count
    assert_equal 66, materials.count
    assert_equal 84, requisitions.count

    topics.destroy_all
    exercises.destroy_all
    materials.destroy_all
    requisitions.destroy_all
  end

end
