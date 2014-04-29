require "test_helper"

class ExerciseFactoryTest < ActiveSupport::TestCase

  setup do
    @topic = topics(:a2)

    fixtures_root = Rails.root.join "test/fixtures/lesson_samples/"
    @a2   = Book::Lesson.new fixtures_root.join "volume_1/2nd_edition/a2.txt"
    @a18  = Book::Lesson.new fixtures_root.join "volume_2/2nd_edition/a18.txt"
    @a22  = Book::Lesson.new fixtures_root.join "volume_3/1st_edition/a22.txt"
    @b22  = Book::Lesson.new fixtures_root.join "volume_2/2nd_edition/b22.txt"
    @b30  = Book::Lesson.new fixtures_root.join "volume_3/1st_edition/b30.txt"
    @c5   = Book::Lesson.new fixtures_root.join "volume_1/2nd_edition/c5.txt"
    @c10  = Book::Lesson.new fixtures_root.join "volume_2/2nd_edition/c10.txt"
    @d5   = Book::Lesson.new fixtures_root.join "volume_1/2nd_edition/d5.txt"
    @d14  = Book::Lesson.new fixtures_root.join "volume_3/1st_edition/d14.txt"
    @a1b1 = Book::Lesson.new fixtures_root.join "volume_1/2nd_edition/a1b1.txt"
  end

  test "#exercises initializes an array of exercises" do
    ExerciseFactory.new(@a2).exercises(@topic).tap do |exercises|
      assert_equal 3, exercises.size
    end

    ExerciseFactory.new(@a18).exercises(@topic).tap do |exercises|
      assert_equal 2, exercises.size
    end

    ExerciseFactory.new(@a22).exercises(@topic).tap do |exercises|
      assert_equal 3, exercises.size
    end

    ExerciseFactory.new(@b22).exercises(@topic).tap do |exercises|
      assert_equal 3, exercises.size
    end

    ExerciseFactory.new(@b30).exercises(@topic).tap do |exercises|
      assert_equal 4, exercises.size
    end

    ExerciseFactory.new(@c5).exercises(@topic).tap do |exercises|
      assert_equal 2, exercises.size
    end

    ExerciseFactory.new(@c10).exercises(@topic).tap do |exercises|
      assert_equal 3, exercises.size
    end

    ExerciseFactory.new(@d5).exercises(@topic).tap do |exercises|
      assert_equal 2, exercises.size
    end

    ExerciseFactory.new(@d14).exercises(@topic).tap do |exercises|
      assert_equal 4, exercises.size
    end

    ExerciseFactory.new(@a1b1).exercises(@topic).tap do |exercises|
      assert_equal 1, exercises.size
    end
  end

  test "#exercises assigns the topic to each exercise" do
    ExerciseFactory.new(@a2).exercises(@topic).tap do |exercises|
      assert_equal @topic, exercises[0].topic
      assert_equal @topic, exercises[1].topic
      assert_equal @topic, exercises[2].topic
    end

    ExerciseFactory.new(@a18).exercises(@topic).tap do |exercises|
      assert_equal @topic, exercises[0].topic
      assert_equal @topic, exercises[1].topic
    end

    ExerciseFactory.new(@a22).exercises(@topic).tap do |exercises|
      assert_equal @topic, exercises[0].topic
      assert_equal @topic, exercises[1].topic
      assert_equal @topic, exercises[2].topic
    end

    ExerciseFactory.new(@b22).exercises(@topic).tap do |exercises|
      assert_equal @topic, exercises[0].topic
      assert_equal @topic, exercises[1].topic
      assert_equal @topic, exercises[2].topic
    end

    ExerciseFactory.new(@b30).exercises(@topic).tap do |exercises|
      assert_equal @topic, exercises[0].topic
      assert_equal @topic, exercises[1].topic
      assert_equal @topic, exercises[2].topic
      assert_equal @topic, exercises[3].topic
    end

    ExerciseFactory.new(@c5).exercises(@topic).tap do |exercises|
      assert_equal @topic, exercises[0].topic
      assert_equal @topic, exercises[1].topic
    end

    ExerciseFactory.new(@c10).exercises(@topic).tap do |exercises|
      assert_equal @topic, exercises[0].topic
      assert_equal @topic, exercises[1].topic
      assert_equal @topic, exercises[2].topic
    end

    ExerciseFactory.new(@d5).exercises(@topic).tap do |exercises|
      assert_equal @topic, exercises[0].topic
      assert_equal @topic, exercises[1].topic
    end

    ExerciseFactory.new(@d14).exercises(@topic).tap do |exercises|
      assert_equal @topic, exercises[0].topic
      assert_equal @topic, exercises[1].topic
      assert_equal @topic, exercises[2].topic
      assert_equal @topic, exercises[3].topic
    end

    ExerciseFactory.new(@a1b1).exercises(@topic).tap do |exercises|
      assert_equal @topic, exercises[0].topic
    end
  end

  test "#exercises maps the name to each exercise" do
    ExerciseFactory.new(@a2).exercises(@topic).tap do |exercises|
      assert_equal "Part 1. Identification of Solids, Liquids, and Gases", exercises[0].name
      assert_equal "Part 2. Changes Between Solid, Liquid, and Gas—Dependence on Temperature", exercises[1].name
      assert_equal "Part 3. States of Matter and Their Common Attributes", exercises[2].name
    end

    ExerciseFactory.new(@a18).exercises(@topic).tap do |exercises|
      assert_equal "Part 1. Creating, Observing, and Interpreting Convection Currents", exercises[0].name
      assert_equal "Part 2. Applying Understanding of Convection Currents: Home Heating to the Earth’s Atmosphere", exercises[1].name
    end

    ExerciseFactory.new(@a22).exercises(@topic).tap do |exercises|
      assert_equal "Part 1. The Chemistry of Acids and Bases", exercises[0].name
      assert_equal "Part 2. pH, Its Meaning, Measurement, and Significance", exercises[1].name
      assert_equal "Part 3. Importance of and Opportunities for Careers in Chemistry", exercises[2].name
    end

    ExerciseFactory.new(@b22).exercises(@topic).tap do |exercises|
      assert_equal "Part 1. Growth of Stems", exercises[0].name
      assert_equal "Part 2. Growth of Roots", exercises[1].name
      assert_equal "Part 3. Growth in Diameter", exercises[2].name
    end

    ExerciseFactory.new(@b30).exercises(@topic).tap do |exercises|
      assert_equal "Part 1. Childhood Diseases and Deaths, Then and Now", exercises[0].name
      assert_equal "Part 2. Discovering the Efficacy Vaccination and the Germ Theory", exercises[1].name
      assert_equal "Part 3. Discovery of Viruses and Their Description", exercises[2].name
      assert_equal "Part 4. Infection by Viruses and the Immune System", exercises[3].name
    end

    ExerciseFactory.new(@c5).exercises(@topic).tap do |exercises|
      assert_equal "Part 1. Revealing the Principle of Inertia", exercises[0].name
      assert_equal "Part 2. Relating Inertia to Energy", exercises[1].name
    end

    ExerciseFactory.new(@c10).exercises(@topic).tap do |exercises|
      assert_equal "Part 1. Review of Inertia", exercises[0].name
      assert_equal "Part 2. Movement Energy and Momentum", exercises[1].name
      assert_equal "Part 3. Momentum and Kinetic Energy", exercises[2].name
    end

    ExerciseFactory.new(@d5).exercises(@topic).tap do |exercises|
      assert_equal "Part 1. Relating Time to the Earth’s Turning", exercises[0].name
      assert_equal "Part 2. Making and Using a Sundial to Tell Time", exercises[1].name
    end

    ExerciseFactory.new(@d14).exercises(@topic).tap do |exercises|
      assert_equal "Part 1. Creating the Background", exercises[0].name
      assert_equal "Part 2. Plotting the Movement of the Moon Around the Earth", exercises[1].name
      assert_equal "Part 3. Eclipses of the Moon and Sun", exercises[2].name
      assert_equal "Part 4. Tides", exercises[3].name
    end

    ExerciseFactory.new(@a1b1).exercises(@topic).tap do |exercises|
      assert_equal "Part 1", exercises[0].name
    end
  end

  test "#exercises maps the body to each exercise" do
    ExerciseFactory.new(@a2).exercises(@topic).tap do |exercises|
      assert_match /\ASet out three boxes/, exercises[0].body
      assert_match /solid parts of the body\.\z/, exercises[0].body
      assert_match /\AHave kids classify an/, exercises[1].body
      assert_match /just introduce the concept\.\z/, exercises[1].body
      assert_match /\AInstruct students that all/, exercises[2].body
      assert_match /repeatedly in future lessons\.\z/, exercises[2].body
    end

    ExerciseFactory.new(@a18).exercises(@topic).tap do |exercises|
      assert_match /\AHave students gather around/, exercises[0].body
      assert_match /and atmosphere \(Lesson D-13\)\.\z/, exercises[0].body
      assert_match /\AThe trend over the past 100/, exercises[1].body
      assert_match /diversity of living things\.\z/, exercises[1].body
    end

    ExerciseFactory.new(@a22).exercises(@topic).tap do |exercises|
      assert_match /\AMost students will have some/, exercises[0].body
      assert_match /same idea pertains to bases\.\z/, exercises[0].body
      assert_match /\AThe actual hydrogen ion \(H\+\)/, exercises[1].body
      assert_match /topics will be your option\.\z/, exercises[1].body
      assert_match /\AWe should not leave these/, exercises[2].body
      assert_match /\(Google: careers in chemistry\)\.\z/, exercises[2].body
    end

    ExerciseFactory.new(@b22).exercises(@topic).tap do |exercises|
      assert_match /\AIn the course of growing/, exercises[0].body
      assert_match /grass flowers as they may choose\.\z/, exercises[0].body
      assert_match /\AThe growth of roots is obviously/, exercises[1].body
      assert_match /remain mysteries for them to solve\.\z/, exercises[1].body
      assert_match /\AStudents have observed that plants/, exercises[2].body
      assert_match /and differentiate as they do\?\z/, exercises[2].body
    end

    ExerciseFactory.new(@b30).exercises(@topic).tap do |exercises|
      assert_match /\ABegin by showing students/, exercises[0].body
      assert_match /and correcting misconceptions\.\z/, exercises[0].body
      assert_match /\AAsk students: Which do you/, exercises[1].body
      assert_match /a mystery and frustration\.\z/, exercises[1].body
      assert_match /\AThe first clue came when a Russian/, exercises[2].body
      assert_match /next part of this lesson\.\z/, exercises[2].body
      assert_match /\ASubsequent research using combined/, exercises[3].body
      assert_match /to reproduce it, mutate, etc\.\z/, exercises[3].body
    end

    ExerciseFactory.new(@c5).exercises(@topic).tap do |exercises|
      assert_match /\ADraw students into a review/, exercises[0].body
      assert_match /of its inertia, and so on\.\z/, exercises[0].body
      assert_match /\AReview the Law of Motion, i\.e\./, exercises[1].body
      assert_match /from any friction involved\.\z/, exercises[1].body
    end

    ExerciseFactory.new(@c10).exercises(@topic).tap do |exercises|
      assert_match /\AWith the lead-in suggested/, exercises[0].body
      assert_match /energy is not recycled\.\z/, exercises[0].body
      assert_match /\AAs students are up to speed/, exercises[1].body
      assert_match /Therefore, Momentum\/mass = velocity\z/, exercises[1].body
      assert_match /\AIt will be inviting to challenge/, exercises[2].body
      assert_match /described in this lesson\.\z/, exercises[2].body
    end

    ExerciseFactory.new(@d5).exercises(@topic).tap do |exercises|
      assert_match /\AAt the beginning of an outdoor/, exercises[0].body
      assert_match /the stars in later years\.\z/, exercises[0].body
      assert_match /\APose the question: Can we tell/, exercises[1].body
      assert_match /from a properly oriented sundial\.\z/, exercises[1].body
    end

    ExerciseFactory.new(@d14).exercises(@topic).tap do |exercises|
      assert_match /\AKids have undoubtedly observed the moon/, exercises[0].body
      assert_match /more critical investigation\.\z/, exercises[0].body
      assert_match /\AThe gist of this part of the/, exercises[1].body
      assert_match /students gain this understanding\.\z/, exercises[1].body
      assert_match /\AFrom observations and discussion/, exercises[2].body
      assert_match /causes of what they observe\.\z/, exercises[2].body
      assert_match /\AMost students will be more or less/, exercises[3].body
      assert_match /firsthand should not be passed up\.\z/, exercises[3].body
    end

    ExerciseFactory.new(@a1b1).exercises(@topic).tap do |exercises|
      assert_match /\AA convenient place/, exercises[0].body
      assert_match /importance of organization\.\z/, exercises[0].body
    end
  end

  test "#exercises maps the part to each exercise" do
    ExerciseFactory.new(@a2).exercises(@topic).tap do |exercises|
      assert_equal 1, exercises[0].part
      assert_equal 2, exercises[1].part
      assert_equal 3, exercises[2].part
    end

    ExerciseFactory.new(@a18).exercises(@topic).tap do |exercises|
      assert_equal 1, exercises[0].part
      assert_equal 2, exercises[1].part
    end

    ExerciseFactory.new(@a22).exercises(@topic).tap do |exercises|
      assert_equal 1, exercises[0].part
      assert_equal 2, exercises[1].part
      assert_equal 3, exercises[2].part
    end

    ExerciseFactory.new(@b22).exercises(@topic).tap do |exercises|
      assert_equal 1, exercises[0].part
      assert_equal 2, exercises[1].part
      assert_equal 3, exercises[2].part
    end

    ExerciseFactory.new(@b30).exercises(@topic).tap do |exercises|
      assert_equal 1, exercises[0].part
      assert_equal 2, exercises[1].part
      assert_equal 3, exercises[2].part
      assert_equal 4, exercises[3].part
    end

    ExerciseFactory.new(@c5).exercises(@topic).tap do |exercises|
      assert_equal 1, exercises[0].part
      assert_equal 2, exercises[1].part
    end

    ExerciseFactory.new(@c10).exercises(@topic).tap do |exercises|
      assert_equal 1, exercises[0].part
      assert_equal 2, exercises[1].part
      assert_equal 3, exercises[2].part
    end

    ExerciseFactory.new(@d5).exercises(@topic).tap do |exercises|
      assert_equal 1, exercises[0].part
      assert_equal 2, exercises[1].part
    end

    ExerciseFactory.new(@d14).exercises(@topic).tap do |exercises|
      assert_equal 1, exercises[0].part
      assert_equal 2, exercises[1].part
      assert_equal 3, exercises[2].part
      assert_equal 4, exercises[3].part
    end

    ExerciseFactory.new(@a1b1).exercises(@topic).tap do |exercises|
      assert_equal 1, exercises[0].part
    end
  end

  test "#exercises finds existing exercises by part" do
    exercises = ExerciseFactory.new(@a2).exercises(@topic)
    exercises.each(&:save!)
    assert_equal exercises, ExerciseFactory.new(@a2).exercises(@topic)
  end

end
