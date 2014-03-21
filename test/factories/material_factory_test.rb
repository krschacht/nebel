require "test_helper"

class MaterialFactoryTest < ActiveSupport::TestCase

  setup do
    @exercise = exercises(:d5_part1)

    fixtures_root = Rails.root.join "test/fixtures/lesson_samples/"
    @a2  = Book::Lesson.new fixtures_root.join "volume_1/2nd_edition/a2.txt"
    @b22 = Book::Lesson.new fixtures_root.join "volume_2/2nd_edition/b22.txt"
  end

  test "#materials initializes an array of materials" do
    MaterialFactory.new(@a2).tap do |material_factory|
      @exercise.part = 1
      assert_equal 3, material_factory.materials(@exercise).size

      @exercise.part = 2
      assert_equal 2, material_factory.materials(@exercise).size

      @exercise.part = 3
      assert_equal 1, material_factory.materials(@exercise).size
    end

    MaterialFactory.new(@b22).tap do |material_factory|
      @exercise.part = 1
      assert_equal 7, material_factory.materials(@exercise).size
    end
  end

  test "#materials maps the original_name" do
    materials_factory = MaterialFactory.new(@a2)

    @exercise.part = 1
    materials_factory.materials(@exercise).tap do |materials|
      assert_match /\AWater and various other liquids/, materials[0].original_name
      assert_match /syrup, shampoo, etc\.\)\z/, materials[0].original_name
      assert_match /\AVarious solid items from around/, materials[1].original_name
      assert_match /pencils, dishes, coins, etc\.\)\z/, materials[1].original_name
      assert_match /\AThree medium-sized cardboard/, materials[2].original_name
      assert_match /can be marked and labeled\.\z/, materials[2].original_name
    end

    @exercise.part = 2
    materials_factory.materials(@exercise).tap do |materials|
      assert_match /\AWater in/, materials[0].original_name
      assert_match /a container\z/, materials[0].original_name
      assert_match /\AIce cubes/, materials[1].original_name
      assert_match /in a bowl\z/, materials[1].original_name
    end

    @exercise.part = 3
    materials_factory.materials(@exercise).tap do |materials|
      assert_match /\ANo additional/, materials[0].original_name
      assert_match /materials needed\z/, materials[0].original_name
    end

    materials_factory = MaterialFactory.new(@b22)

    @exercise.part = 1
    materials_factory.materials(@exercise).tap do |materials|
      assert_match /\AThis lesson entails ongoing/, materials[0].original_name
      assert_match /the following will be utilized\.\z/, materials[0].original_name
      assert_match /\ATape/, materials[1].original_name
      assert_match /measure\z/, materials[1].original_name
      assert_match /\AFine tipped/, materials[2].original_name
      assert_match /Sharpie™\z/, materials[2].original_name
      assert_match /\ADissecting microscope is ideal/, materials[3].original_name
      assert_match /pocket magnifiers\.\)\z/, materials[3].original_name
      assert_match /\ADissecting tools/, materials[4].original_name
      assert_match /teasing needles, etc\.\)\z/, materials[4].original_name
      assert_match /\ACompound microscope/, materials[5].original_name
      assert_match /sections of woody stems\z/, materials[5].original_name
      assert_match /\APhotomicrographs of the above/, materials[6].original_name
      assert_match /are included below\.\z/, materials[6].original_name
    end
  end

  test "#materials finds existing materials by original name" do
    materials = MaterialFactory.new(@a2).materials(@exercise)
    materials.each do |material|
      material.save!
      Requisition.create! exercise_id: @exercise.id, material_id: material.id
    end
    assert_equal materials, MaterialFactory.new(@a2).materials(@exercise)
  end

end
