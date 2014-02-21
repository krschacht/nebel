require "test_helper"

class ExerciseFactoryTest < ActiveSupport::TestCase
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

  test "#exercises" do
    exercises = ExerciseFactory.new(@a2).exercises
    assert_equal 3, exercises.size
    assert_equal "Part 1. Identification of Solids, Liquids, and Gases", exercises[0].name
    assert_equal "Part 2. Changes Between Solid, Liquid, and Gas—Dependence on Temperature", exercises[1].name
    assert_equal "Part 3. States of Matter and Their Common Attributes", exercises[2].name
    assert_match /\ASet out three boxes/, exercises[0].body
    assert_match /solid parts of the body\.\z/, exercises[0].body
    assert_match /\AHave kids classify an/, exercises[1].body
    assert_match /just introduce the concept\.\z/, exercises[1].body
    assert_match /\AInstruct students that all/, exercises[2].body
    assert_match /repeatedly in future lessons\.\z/, exercises[2].body
    assert_equal "demonstration, game/activity, interpretation; 40-50 minutes", exercises[0].duration
    assert_equal "demonstrations with interpretive discussion; 20-30 minutes", exercises[1].duration
    assert_equal "instruction and thought exercises; 30-40 minutes", exercises[2].duration
    assert_match /\AWater and various other liquids/, exercises[0].materials
    assert_match /can be marked and labeled\.\z/, exercises[0].materials
    assert_match /\AWater in a container/, exercises[1].materials
    assert_match /Ice cubes in a bowl\z/, exercises[1].materials
    assert_match /\ANo additional/, exercises[2].materials
    assert_match /materials needed\z/, exercises[2].materials

    exercises = ExerciseFactory.new(@a18).exercises
    assert_equal 2, exercises.size
    assert_equal "Part 1. Creating, Observing, and Interpreting Convection Currents", exercises[0].name
    assert_equal "Part 2. Applying Understanding of Convection Currents: Home Heating to the Earth’s Atmosphere", exercises[1].name
    assert_match /\AHave students gather around/, exercises[0].body
    assert_match /and atmosphere \(Lesson D-13\)\.\z/, exercises[0].body
    assert_match /\AThe trend over the past 100/, exercises[1].body
    assert_match /diversity of living things\.\z/, exercises[1].body
    assert_equal "demonstration, 30-45 minutes; interpretive discussion, 35-45 minutes", exercises[0].duration
    assert_equal "activity and analysis, 1-2 hours", exercises[1].duration
    assert_match /\ABurner or hot plate/, exercises[0].materials
    assert_match /Food dye \(any color\)\z/, exercises[0].materials
    assert_match /\ADiagrams of utilizing convection/, exercises[1].materials
    assert_match /produces smoke will work\)\z/, exercises[1].materials

    exercises = ExerciseFactory.new(@a22).exercises
    assert_equal 3, exercises.size
    assert_equal "Part 1. The Chemistry of Acids and Bases", exercises[0].name
    assert_equal "Part 2. pH, Its Meaning, Measurement, and Significance", exercises[1].name
    assert_equal "Part 3. Importance of and Opportunities for Careers in Chemistry", exercises[2].name
    assert_match /\AMost students will have some/, exercises[0].body
    assert_match /same idea pertains to bases\.\z/, exercises[0].body
    assert_match /\AThe actual hydrogen ion \(H\+\)/, exercises[1].body
    assert_match /topics will be your option\.\z/, exercises[1].body
    assert_match /\AWe should not leave these/, exercises[2].body
    assert_match /\(Google: careers in chemistry\)\.\z/, exercises[2].body
    assert_equal "lecture, discussion, reflection, learning games, 1-2 hours", exercises[0].duration
    assert_equal "lecture, discussion, demonstration, 40-50 minutes; measuring/recording pH, open ended", exercises[1].duration
    assert_equal "open ended", exercises[2].duration
    assert_match /\APurplish water from boiled/, exercises[0].materials
    assert_match /substances as may be available\z/, exercises[0].materials
    assert_match /\ApH indicator paper with a range/, exercises[1].materials
    assert_match /sources for practice testing\z/, exercises[1].materials
    assert_match /\ANo materials/, exercises[2].materials
    assert_match /are necessary\z/, exercises[2].materials

    exercises = ExerciseFactory.new(@b22).exercises
    assert_equal 3, exercises.size
    assert_equal "Part 1. Growth of Stems", exercises[0].name
    assert_equal "Part 2. Growth of Roots", exercises[1].name
    assert_equal "Part 3. Growth in Diameter", exercises[2].name
    assert_match /\AIn the course of growing/, exercises[0].body
    assert_match /grass flowers as they may choose\.\z/, exercises[0].body
    assert_match /\AThe growth of roots is obviously/, exercises[1].body
    assert_match /remain mysteries for them to solve\.\z/, exercises[1].body
    assert_match /\AStudents have observed that plants/, exercises[2].body
    assert_match /and differentiate as they do\?\z/, exercises[2].body
    assert_nil exercises[0].duration
    assert_nil exercises[1].duration
    assert_nil exercises[2].duration
    assert_nil exercises[0].materials
    assert_nil exercises[0].materials
    assert_nil exercises[0].materials

    exercises = ExerciseFactory.new(@b30).exercises
    assert_equal 4, exercises.size
    assert_equal "Part 1. Childhood Diseases and Deaths, Then and Now", exercises[0].name
    assert_equal "Part 2. Discovering the Efficacy Vaccination and the Germ Theory", exercises[1].name
    assert_equal "Part 3. Discovery of Viruses and Their Description", exercises[2].name
    assert_equal "Part 4. Infection by Viruses and the Immune System", exercises[3].name
    assert_match /\ABegin by showing students/, exercises[0].body
    assert_match /and correcting misconceptions\.\z/, exercises[0].body
    assert_match /\AAsk students: Which do you/, exercises[1].body
    assert_match /a mystery and frustration\.\z/, exercises[1].body
    assert_match /\AThe first clue came when a Russian/, exercises[2].body
    assert_match /next part of this lesson\.\z/, exercises[2].body
    assert_match /\ASubsequent research using combined/, exercises[3].body
    assert_match /to reproduce it, mutate, etc\.\z/, exercises[3].body
    assert_equal "presentation, Q and A discussion, 30-40 minutes", exercises[0].duration
    assert_equal "presentation, Q and A discussion, 30-40 minutes", exercises[0].duration
    assert_equal "presentation, Q and A discussion, 30-40 minutes, repetition of Pasteur’s experiment, 1-2 hours", exercises[1].duration
    assert_equal "presentation, Q and A discussion, 30-40 minutes, model building, 1-2 hours", exercises[2].duration
    assert_equal "presentation, Q and A discussion, 40-60 minutes", exercises[3].duration
    assert_match /\AList of diseases prevented/, exercises[0].materials
    assert_match /infants and children photo\)\z/, exercises[0].materials
    assert_match /\AReadings describing Edward Jenner’s/, exercises[1].materials
    assert_match /\(Google: Koch’s postulates\)\z/, exercises[1].materials
    assert_match /\AElectron micrographs of viruses/, exercises[2].materials
    assert_match /\(Google: virus life cycle animation\)\z/, exercises[2].materials
    assert_match /\ADiagrams and\/or videos depicting/, exercises[3].materials
    assert_match /function diagrams animations\)\z/, exercises[3].materials

    exercises = ExerciseFactory.new(@c5).exercises
    assert_equal 2, exercises.size
    assert_equal "Part 1. Revealing the Principle of Inertia", exercises[0].name
    assert_equal "Part 2. Relating Inertia to Energy", exercises[1].name
    assert_match /\ADraw students into a review/, exercises[0].body
    assert_match /of its inertia, and so on\.\z/, exercises[0].body
    assert_match /\AReview the Law of Motion, i\.e\./, exercises[1].body
    assert_match /from any friction involved\.\z/, exercises[1].body
    assert_equal "demonstrations, observations, interpretive discussion; 50-60 minutes, plus games/activities as desired", exercises[0].duration
    assert_equal "observations, reasoning, interpretive discussion; 30-40 minutes", exercises[1].duration
    assert_match /\AFor the activities described/, exercises[0].materials
    assert_match /shown in the video\.\z/, exercises[0].materials
    assert_match /\ANo additional/, exercises[1].materials
    assert_match /materials needed\z/, exercises[1].materials

    exercises = ExerciseFactory.new(@c10).exercises
    assert_equal 3, exercises.size
    assert_equal "Part 1. Review of Inertia", exercises[0].name
    assert_equal "Part 2. Movement Energy and Momentum", exercises[1].name
    assert_equal "Part 3. Momentum and Kinetic Energy", exercises[2].name
    assert_match /\AWith the lead-in suggested/, exercises[0].body
    assert_match /energy is not recycled\.\z/, exercises[0].body
    assert_match /\AAs students are up to speed/, exercises[1].body
    assert_match /Therefore, Momentum\/mass = velocity\z/, exercises[1].body
    assert_match /\AIt will be inviting to challenge/, exercises[2].body
    assert_match /described in this lesson\.\z/, exercises[2].body
    assert_equal "review as necessary", exercises[0].duration
    assert_equal "examples drawing on experience plus interpretive discussion; 40-50 minutes", exercises[1].duration
    assert_equal "calculations, experimentation as desired", exercises[2].duration
    assert_nil exercises[0].materials
    assert_nil exercises[1].materials
    assert_nil exercises[2].materials

    exercises = ExerciseFactory.new(@d5).exercises
    assert_equal 2, exercises.size
    assert_equal "Part 1. Relating Time to the Earth’s Turning", exercises[0].name
    assert_equal "Part 2. Making and Using a Sundial to Tell Time", exercises[1].name
    assert_match /\AAt the beginning of an outdoor/, exercises[0].body
    assert_match /the stars in later years\.\z/, exercises[0].body
    assert_match /\APose the question: Can we tell/, exercises[1].body
    assert_match /from a properly oriented sundial\.\z/, exercises[1].body
    assert_equal "15 minute activity at the beginning and end of an outdoor recreational period followed by interpretive discussion; 30-40 minutes", exercises[0].duration
    assert_equal "Making the sundial; 40-50 minutes plus 5-10 minutes each hour over the course of the day to calibrate it", exercises[1].duration
    assert_match /\ASunny location and chalk/, exercises[0].materials
    assert_match /as in Lesson D-2\z/, exercises[0].materials
    assert_match /\APiece of poster paper/, exercises[1].materials
    assert_match /Pencil and straightedge\z/, exercises[1].materials

    exercises = ExerciseFactory.new(@d14).exercises
    assert_equal 4, exercises.size
    assert_equal "Part 1. Creating the Background", exercises[0].name
    assert_equal "Part 2. Plotting the Movement of the Moon Around the Earth", exercises[1].name
    assert_equal "Part 3. Eclipses of the Moon and Sun", exercises[2].name
    assert_equal "Part 4. Tides", exercises[3].name
    assert_match /\AKids have undoubtedly observed the moon/, exercises[0].body
    assert_match /more critical investigation\.\z/, exercises[0].body
    assert_match /\AThe gist of this part of the/, exercises[1].body
    assert_match /students gain this understanding\.\z/, exercises[1].body
    assert_match /\AFrom observations and discussion/, exercises[2].body
    assert_match /causes of what they observe\.\z/, exercises[2].body
    assert_match /\AMost students will be more or less/, exercises[3].body
    assert_match /firsthand should not be passed up\.\z/, exercises[3].body
    assert_equal "assigning “homework” and discussion as deemed necessary; may be omitted if students have already mastered the content", exercises[0].duration
    assert_equal "“homework” with support from parents or others, time as necessary to make arrangements; follow-up discussion and analysis of results, 1-2 hours", exercises[1].duration
    assert_equal "modeling and interpretation, 40-50 minutes", exercises[2].duration
    assert_equal "correlating data, 40-50 minutes; analysis and interpretation 40-50 minutes", exercises[3].duration
    assert_match /\AGraph/, exercises[0].materials
    assert_match /paper\z/, exercises[0].materials
    assert_match /\AThe key factor in/, exercises[1].materials
    assert_match /“Sticky notes”\z/, exercises[1].materials
    assert_match /\ANo particular materials/, exercises[2].materials
    assert_match /lunar eclipse video\)\.\z/, exercises[2].materials
    assert_match /\AIf students have not had/, exercises[3].materials
    assert_match /\(Google: intertidal zones\)\z/, exercises[3].materials
  end
end
