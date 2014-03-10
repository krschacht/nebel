require "test_helper"

class MaterialFactoryTest < ActiveSupport::TestCase

  setup do
    fixtures_root = Rails.root.join "test/fixtures/lesson_samples/"
    @a2  = Book::Lesson.new fixtures_root.join "volume_1/2nd_edition/a2.txt"
    @a18 = Book::Lesson.new fixtures_root.join "volume_2/2nd_edition/a18.txt"
    @a22 = Book::Lesson.new fixtures_root.join "volume_3/1st_edition/a22.txt"
    @b22 = Book::Lesson.new fixtures_root.join "volume_2/2nd_edition/b22.txt"
    @b30 = Book::Lesson.new fixtures_root.join "volume_3/1st_edition/b30.txt"
    @c5  = Book::Lesson.new fixtures_root.join "volume_1/2nd_edition/c5.txt"
    @c10 = Book::Lesson.new fixtures_root.join "volume_2/2nd_edition/c10.txt"
    @d5  = Book::Lesson.new fixtures_root.join "volume_1/2nd_edition/d5.txt"
    @d14 = Book::Lesson.new fixtures_root.join "volume_3/1st_edition/d14.txt"
  end


  test "#materials" do
    materials = MaterialFactory.new(@a2).materials
    assert_equal 3, materials[0].size
    assert_match /\AWater and various other liquids/, materials[0][0].original_name
    assert_match /syrup, shampoo, etc\.\)\z/, materials[0][0].original_name
    assert_match /\AVarious solid items from around/, materials[0][1].original_name
    assert_match /pencils, dishes, coins, etc\.\)\z/, materials[0][1].original_name
    assert_match /\AThree medium-sized cardboard/, materials[0][2].original_name
    assert_match /can be marked and labeled\.\z/, materials[0][2].original_name
  end

end
