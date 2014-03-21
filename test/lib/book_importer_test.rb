require "test_helper"
require "book_importer"

class BookImporterTest < ActiveSupport::TestCase

  test "#import creates topics, exercises, materials, and requisitions" do
    start_of_test = Time.now
    lesson_paths  = Rails.root.join "test/fixtures/lesson_samples/**/*.txt"
    book_importer = BookImporter.new Dir[lesson_paths]
    topics        = Topic.where("created_at > ?", start_of_test)
    exercises     = Exercise.where("created_at > ?", start_of_test)
    materials     = Material.where("created_at > ?", start_of_test)
    requisitions  = Requisition.where("created_at > ?", start_of_test)

    book_importer.import

    assert_equal 10, topics.count
    assert_equal 27, exercises.count
    assert_equal 86, materials.count
    assert_equal 86, requisitions.count

    topics.destroy_all
    exercises.destroy_all
    materials.destroy_all
    requisitions.destroy_all
  end

  test "#import does not recreate materials that already exist" do
    start_of_test = Time.now
    lesson_paths  = Rails.root.join "test/fixtures/lesson_samples/volume_1/**/*.txt"
    book_importer = BookImporter.new Dir[lesson_paths]
    topics        = Topic.where("created_at > ?", start_of_test)
    exercises     = Exercise.where("created_at > ?", start_of_test)
    materials     = Material.where("created_at > ?", start_of_test)
    requisitions  = Requisition.where("created_at > ?", start_of_test)

    book_importer.import

    original_number_of_materials    = materials.count
    original_number_of_requisitions = requisitions.count

    book_importer.import

    assert_equal original_number_of_materials, materials.count
    assert_equal original_number_of_requisitions, requisitions.count

    topics.destroy_all
    exercises.destroy_all
    materials.destroy_all
    requisitions.destroy_all
  end

end
