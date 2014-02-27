require 'test_helper'
require "book"

class BookTest < ActiveSupport::TestCase

  class LessonTest < ActiveSupport::TestCase

    setup do
      fixtures_root = Rails.root.join "test/fixtures/lesson_samples/"
      @a2  = fixtures_root.join "volume_1/2nd_edition/a2.txt"
      @a18 = fixtures_root.join "volume_2/2nd_edition/a18.txt"
      @a22 = fixtures_root.join "volume_3/1st_edition/a22.txt"
      @b22 = fixtures_root.join "volume_2/2nd_edition/b22.txt"
      @b30 = fixtures_root.join "volume_3/1st_edition/b30.txt"
      @c5  = fixtures_root.join "volume_1/2nd_edition/c5.txt"
      @c10 = fixtures_root.join "volume_2/2nd_edition/c10.txt"
      @d5  = fixtures_root.join "volume_1/2nd_edition/d5.txt"
      @d14 = fixtures_root.join "volume_3/1st_edition/d14.txt"
    end

    test "initializes with the lesson text" do
      lesson = Book::Lesson.new("lesson text...")
      assert_equal "lesson text...", lesson.text
    end

    test "initializes with the a file path" do
      lesson = Book::Lesson.new(@c5)
      assert_equal File.read(@c5), lesson.text
    end

    test "#name" do
      lesson = Book::Lesson.new(@a2)
      assert_equal "Solids, Liquids, and Gases and\nChange With Temperature", lesson.name

      lesson = Book::Lesson.new(@a18)
      assert_equal "Convection Currents:\nObservation and Interpretation", lesson.name

      lesson = Book::Lesson.new(@a22)
      assert_equal "Concepts of Chemistry V\nAcids and Bases", lesson.name

      lesson = Book::Lesson.new(@b22)
      assert_equal "The Life of Plants II:\nHow a Plant Grows Its Parts", lesson.name

      lesson = Book::Lesson.new(@b30)
      assert_equal "Viruses: Their Attack Nature, Attack, and \nOur Defense", lesson.name

      lesson = Book::Lesson.new(@c5)
      assert_equal "Inertia", lesson.name

      lesson = Book::Lesson.new(@c10)
      assert_equal "Movement Energy and Momentum", lesson.name

      lesson = Book::Lesson.new(@d5)
      assert_equal "Time and the Earth’s Turning", lesson.name

      lesson = Book::Lesson.new(@d14)
      assert_equal "The Moon and Its Phases, \nand Tides", lesson.name

      lesson = Book::Lesson.new("Lesson A/B-1\n\nOrganizing Things Into Categories\n\n\n\nOverview:")
      assert_equal "Organizing Things Into Categories", lesson.name

      lesson = Book::Lesson.new("Lesson A-5A\n\nMagnets and Magnetic Fields\n\n\n\nOverview:")
      assert_equal "Magnets and Magnetic Fields", lesson.name

      lesson = Book::Lesson.new("Lesson B-4B\n\nWhat is a Species?\n\n\n\nOverview:")
      assert_equal "What is a Species?", lesson.name
    end

    test "#full_lesson_code" do
      lesson = Book::Lesson.new(@a2)
      assert_equal "A-2", lesson.full_lesson_code

      lesson = Book::Lesson.new(@a18)
      assert_equal "A-18", lesson.full_lesson_code

      lesson = Book::Lesson.new(@a22)
      assert_equal "A-22", lesson.full_lesson_code

      lesson = Book::Lesson.new(@b22)
      assert_equal "B-22", lesson.full_lesson_code

      lesson = Book::Lesson.new(@b30)
      assert_equal "B-30", lesson.full_lesson_code

      lesson = Book::Lesson.new(@c5)
      assert_equal "C-5", lesson.full_lesson_code

      lesson = Book::Lesson.new(@c10)
      assert_equal "C-10", lesson.full_lesson_code

      lesson = Book::Lesson.new(@d5)
      assert_equal "D-5", lesson.full_lesson_code

      lesson = Book::Lesson.new(@d14)
      assert_equal "D-14", lesson.full_lesson_code

      lesson = Book::Lesson.new("Lesson A/B-1\n\nOrganizing Things Into Categories\n\n\n\nOverview:")
      assert_equal "A/B-1", lesson.full_lesson_code

      lesson = Book::Lesson.new("Lesson B-4B\n\nWhat is a Species?\n\n\n\nOverview:")
      assert_equal "B-4B", lesson.full_lesson_code
    end

    test "#subject_code" do
      lesson = Book::Lesson.new(@a2)
      assert_equal "A", lesson.subject_code

      lesson = Book::Lesson.new(@a18)
      assert_equal "A", lesson.subject_code

      lesson = Book::Lesson.new(@a22)
      assert_equal "A", lesson.subject_code

      lesson = Book::Lesson.new(@b22)
      assert_equal "B", lesson.subject_code

      lesson = Book::Lesson.new(@b30)
      assert_equal "B", lesson.subject_code

      lesson = Book::Lesson.new(@c5)
      assert_equal "C", lesson.subject_code

      lesson = Book::Lesson.new(@c10)
      assert_equal "C", lesson.subject_code

      lesson = Book::Lesson.new(@d5)
      assert_equal "D", lesson.subject_code

      lesson = Book::Lesson.new(@d14)
      assert_equal "D", lesson.subject_code
    end

    test "#number" do
      lesson = Book::Lesson.new(@a2)
      assert_equal 2, lesson.number

      lesson = Book::Lesson.new(@a18)
      assert_equal 18, lesson.number

      lesson = Book::Lesson.new(@a22)
      assert_equal 22, lesson.number

      lesson = Book::Lesson.new(@b22)
      assert_equal 22, lesson.number

      lesson = Book::Lesson.new(@b30)
      assert_equal 30, lesson.number

      lesson = Book::Lesson.new(@c5)
      assert_equal 5, lesson.number

      lesson = Book::Lesson.new(@c10)
      assert_equal 10, lesson.number

      lesson = Book::Lesson.new(@d5)
      assert_equal 5, lesson.number

      lesson = Book::Lesson.new(@d14)
      assert_equal 14, lesson.number
    end

    test "#overview" do
      lesson = Book::Lesson.new(@a2)
      assert_match /\AIn this lesson students/, lesson.overview
      assert_match /temperature; others don’t\.\z/, lesson.overview

      lesson = Book::Lesson.new(@a18)
      assert_match /\AIn this lesson, students/, lesson.overview
      assert_match /passive solar energy\.\z/, lesson.overview

      lesson = Book::Lesson.new(@a22)
      assert_match /\AStudents will go beyond/, lesson.overview
      assert_match /for careers in chemistry\.\z/, lesson.overview

      lesson = Book::Lesson.new(@b22)
      assert_match /\ADovetailing with growing/, lesson.overview
      assert_match /leaf versus a flower\.\z/, lesson.overview

      lesson = Book::Lesson.new(@b30)
      assert_match /\AStarting with an overview/, lesson.overview
      assert_match /and cure of diseases\.\z/, lesson.overview

      lesson = Book::Lesson.new(@c5)
      assert_match /\AThrough observation and analysis/, lesson.overview
      assert_match /energy inputs and outputs\.\z/, lesson.overview

      lesson = Book::Lesson.new(@c10)
      assert_match /\AFollowing a review/, lesson.overview
      assert_match /calculations may be included\.\z/, lesson.overview

      lesson = Book::Lesson.new(@d5)
      assert_match /\AIn this lesson, students/, lesson.overview
      assert_match /them in telling time\.\z/, lesson.overview

      lesson = Book::Lesson.new(@d14)
      assert_match /\AWhile people can hardly/, lesson.overview
      assert_match /importance of intertidal zones\.\z/, lesson.overview
    end

    test "#position" do
      lesson = Book::Lesson.new(@a2)
      assert_match /\ABeyond the progression/, lesson.position
      assert_match /sciences as well\.\z/, lesson.position

      lesson = Book::Lesson.new(@a18)
      assert_match /\AThis lesson makes a/, lesson.position
      assert_match /patterns around the globe\.\z/, lesson.position

      lesson = Book::Lesson.new(@a22)
      assert_nil lesson.position

      lesson = Book::Lesson.new(@b22)
      assert_match /\AIn this lesson students/, lesson.position
      assert_match /answers from collected data\.\z/, lesson.position

      lesson = Book::Lesson.new(@b30)
      assert_nil lesson.position

      lesson = Book::Lesson.new(@c5)
      assert_match /\AInertia’s designation as/, lesson.position
      assert_match /lessons of this thread\.\z/, lesson.position

      lesson = Book::Lesson.new(@c10)
      assert_match /\ABuilding on students’ introduction/, lesson.position
      assert_match /weather, or space flight\.\z/, lesson.position

      lesson = Book::Lesson.new(@d5)
      assert_match /\AIn this lesson, students/, lesson.position
      assert_match /and the heavens above\.\z/, lesson.position

      lesson = Book::Lesson.new(@d14)
      assert_nil lesson.position
   end

    test "#time_required" do
      lesson = Book::Lesson.new(@a2)
      assert_match /\APart 1\. Identification of/, lesson.time_required
      assert_match /exercises; 30-40 minutes\)\z/, lesson.time_required

      lesson = Book::Lesson.new(@a18)
      assert_match /\APart 1\. Creating, Observing,/, lesson.time_required
      assert_match /and analysis, 1-2 hours\)\z/, lesson.time_required

      lesson = Book::Lesson.new(@a22)
      assert_match /\APart 1\. The Chemistry/, lesson.time_required
      assert_match /in Chemistry \(open ended\)\z/, lesson.time_required

      lesson = Book::Lesson.new(@b22)
      assert_match /\ACarried out during the/, lesson.time_required
      assert_match /reading over the lesson\.\z/, lesson.time_required

      lesson = Book::Lesson.new(@b30)
      assert_match /\APart 1\. Childhood Disease/, lesson.time_required
      assert_match /discussion, 40-60 minutes\)\z/, lesson.time_required

      lesson = Book::Lesson.new(@c5)
      assert_match /\APart 1\. Revealing the Principle/, lesson.time_required
      assert_match /discussion; 30-40 minutes\)\z/, lesson.time_required

      lesson = Book::Lesson.new(@c10)
      assert_match /\APart 1\. Review of Inertia/, lesson.time_required
      assert_match /experimentation as desired\)\z/, lesson.time_required

      lesson = Book::Lesson.new(@d5)
      assert_match /\APart 1\.\s+Relating Time/, lesson.time_required
      assert_match /the day to calibrate it\)\z/, lesson.time_required

      lesson = Book::Lesson.new(@d14)
      assert_match /\APart 1\. Creating the Background/, lesson.time_required
      assert_match /interpretation 40-50 minutes\)\z/, lesson.time_required
    end

    test "#objectives" do
      lesson = Book::Lesson.new(@a2)
      assert_match /\AStudents who demonstrate/, lesson.objectives
      assert_match /don’t occupy space\.\z/, lesson.objectives

      lesson = Book::Lesson.new(@a18)
      assert_match /\AStudents who demonstrate/, lesson.objectives
      assert_match /and in the atmosphere\.\z/, lesson.objectives

      lesson = Book::Lesson.new(@a22)
      assert_match /\AThrough this exercise,/, lesson.objectives
      assert_match /careers in chemistry\.\z/, lesson.objectives

      lesson = Book::Lesson.new(@b22)
      assert_match /\AStudents who demonstrate/, lesson.objectives
      assert_match /cells of the same plant\.\z/, lesson.objectives

      lesson = Book::Lesson.new(@b30)
      assert_match /\AThrough this exercise,/, lesson.objectives
      assert_match /of the diseases they cause\.\z/, lesson.objectives

      lesson = Book::Lesson.new(@c5)
      assert_match /\AThrough this exercise/, lesson.objectives
      assert_match /materialize out of nothing\.\z/, lesson.objectives

      lesson = Book::Lesson.new(@c10)
      assert_match /\AStudents who demonstrate/, lesson.objectives
      assert_match /measurement of kinetic energy\.\z/, lesson.objectives

      lesson = Book::Lesson.new(@d5)
      assert_match /\AStudents who demonstrate/, lesson.objectives
      assert_match /aspects remain constant\.\z/, lesson.objectives

      lesson = Book::Lesson.new(@d14)
      assert_match /\AThrough this exercise,/, lesson.objectives
      assert_match /the phase of the moon\.\z/, lesson.objectives
    end

    test "#required_background" do
      lesson = Book::Lesson.new(@a2)
      assert_match /\ALesson A\/B-1, Organizing/, lesson.required_background
      assert_match /Things Into Categories\z/, lesson.required_background

      lesson = Book::Lesson.new(@a18)
      assert_match /\ALesson A-15. Concept/, lesson.required_background
      assert_match /of Seasonal Changes\z/, lesson.required_background

      lesson = Book::Lesson.new(@a22)
      assert_match /\ALesson A-20, Concepts/, lesson.required_background
      assert_match /Concepts of Chemistry IV\z/, lesson.required_background

      lesson = Book::Lesson.new(@b22)
      assert_match /\ALesson B-21, The Life/, lesson.required_background
      assert_match /Cells I and Cells II\z/, lesson.required_background

      lesson = Book::Lesson.new(@b30)
      assert_match /\ALesson A-20, Concepts/, lesson.required_background
      assert_match /Cells V: Reproduction\z/, lesson.required_background

      lesson = Book::Lesson.new(@c5)
      assert_match /\ALesson C-1, Concepts/, lesson.required_background
      assert_match /Between Matter and Energy\z/, lesson.required_background

      lesson = Book::Lesson.new(@c10)
      assert_match /\ALesson C-1, Concepts of/, lesson.required_background
      assert_match /Lesson C-6, Friction \[Vol. I\]\z/, lesson.required_background

      lesson = Book::Lesson.new(@d5)
      assert_match /\ALesson D-2, Day and Night/, lesson.required_background
      assert_match /telling time is assumed\z/, lesson.required_background

      lesson = Book::Lesson.new(@d14)
      assert_match /\AA general familiarity/, lesson.required_background
      assert_match /two weeks is assumed\.\z/, lesson.required_background
    end

    test "#materials" do
      lesson = Book::Lesson.new(@a2)
      assert_match /\APart 1. Identification/, lesson.materials
      assert_match /additional materials needed\z/, lesson.materials

      lesson = Book::Lesson.new(@a18)
      assert_match /\APart 1. Creating, Observing/, lesson.materials
      assert_match /produces smoke will work\)\z/, lesson.materials

      lesson = Book::Lesson.new(@a22)
      assert_match /\APart 1. The Chemistry/, lesson.materials
      assert_match /No materials are necessary\z/, lesson.materials

      lesson = Book::Lesson.new(@b22)
      assert_match /\AThis lesson entails ongoing/, lesson.materials
      assert_match /references are included below\.\z/, lesson.materials

      lesson = Book::Lesson.new(@b30)
      assert_match /\APart 1. Childhood Disease/, lesson.materials
      assert_match /function diagrams animations\)\z/, lesson.materials

      lesson = Book::Lesson.new(@c5)
      assert_match /\APart 1. Revealing the/, lesson.materials
      assert_match /additional materials needed\z/, lesson.materials

      lesson = Book::Lesson.new(@c10)
      assert_match /\AMomentum is a measure/, lesson.materials
      assert_match /things in their mouths\.\z/, lesson.materials

      lesson = Book::Lesson.new(@d5)
      assert_match /\APart 1. Relating Time to/, lesson.materials
      assert_match /Pencil and straightedge\z/, lesson.materials

      lesson = Book::Lesson.new(@d14)
      assert_match /\APart 1. Creating the Background/, lesson.materials
      assert_match /zones \(Google: intertidal zones\)\z/, lesson.materials
    end

    test "#teachable_moments" do
      lesson = Book::Lesson.new(@a2)
      assert_match /\AIntroduce this exercise/, lesson.teachable_moments
      assert_match /any convenient time\.\z/, lesson.teachable_moments

      lesson = Book::Lesson.new(@a18)
      assert_match /\AHaving students help/, lesson.teachable_moments
      assert_match /its own teachable moment\.\z/, lesson.teachable_moments

      lesson = Book::Lesson.new(@a22)
      assert_match /\ADemonstrating beet or red/, lesson.teachable_moments
      assert_match /reaction will attract attention\.\z/, lesson.teachable_moments

      lesson = Book::Lesson.new(@b22)
      assert_match /\AGrowing and maintaining/, lesson.teachable_moments
      assert_match /lesson\(s\) at hand\.\z/, lesson.teachable_moments

      lesson = Book::Lesson.new(@b30)
      assert_match /\AShowing pictures, reading stories/, lesson.teachable_moments
      assert_match /its own teachable moments\.\z/, lesson.teachable_moments

      lesson = Book::Lesson.new(@c5)
      assert_match /\AUse a demonstration/, lesson.teachable_moments
      assert_match /the games described\.\z/, lesson.teachable_moments

      lesson = Book::Lesson.new(@c10)
      assert_match /\AAct out pushing, kicking/, lesson.teachable_moments
      assert_match /activities of everyday life\.\z/, lesson.teachable_moments

      lesson = Book::Lesson.new(@d5)
      assert_match /\AThis lesson can be inserted/, lesson.teachable_moments
      assert_match /period and note the shift\.\z/, lesson.teachable_moments

      lesson = Book::Lesson.new(@d14)
      assert_match /\AAt any time there is a clear/, lesson.teachable_moments
      assert_match /it in a more systematic way\.\z/, lesson.teachable_moments
    end

    test "#methods_and_procedures" do
      lesson = Book::Lesson.new(@a2)
      assert_match /\APart 1. Identification/, lesson.methods_and_procedures
      assert_match /in future lessons\.\z/, lesson.methods_and_procedures

      lesson = Book::Lesson.new(@a18)
      assert_match /\APart 1. Creating, Observing/, lesson.methods_and_procedures
      assert_match /diversity of living things\.\z/, lesson.methods_and_procedures

      lesson = Book::Lesson.new(@a22)
      assert_match /\APart 1. The Chemistry/, lesson.methods_and_procedures
      assert_match /\(Google: careers in chemistry\)\.\z/, lesson.methods_and_procedures

      lesson = Book::Lesson.new(@b22)
      assert_match /\APart 1. Growth of Stems/, lesson.methods_and_procedures
      assert_match /differentiate as they do\?\z/, lesson.methods_and_procedures

      lesson = Book::Lesson.new(@b30)
      assert_match /\APart 1. Childhood Diseases/, lesson.methods_and_procedures
      assert_match /reproduce it, mutate, etc\.\z/, lesson.methods_and_procedures

      lesson = Book::Lesson.new(@c5)
      assert_match /\APart 1. Revealing the/, lesson.methods_and_procedures
      assert_match /any friction involved\.\z/, lesson.methods_and_procedures

      lesson = Book::Lesson.new(@c10)
      assert_match /\APart 1. Review of Inertia/, lesson.methods_and_procedures
      assert_match /described in this lesson\.\z/, lesson.methods_and_procedures

      lesson = Book::Lesson.new(@d5)
      assert_match /\APart 1. Relating Time to /, lesson.methods_and_procedures
      assert_match /properly oriented sundial\.\z/, lesson.methods_and_procedures

      lesson = Book::Lesson.new(@d14)
      assert_match /\APart 1\. Creating the Background/, lesson.methods_and_procedures
      assert_match /firsthand should not be passed up\.\z/, lesson.methods_and_procedures
    end

    test "#questions" do
      lesson = Book::Lesson.new(@a2)
      assert_match /\AStudents should make/, lesson.questions
      assert_match /What are they\?\z/, lesson.questions

      lesson = Book::Lesson.new(@a18)
      assert_match /\AStudents should record/, lesson.questions
      assert_match /Google: passive solar design\.\z/, lesson.questions

      lesson = Book::Lesson.new(@a22)
      assert_match /\AStudents should record/, lesson.questions
      assert_match /lives in the future\?\z/, lesson.questions

      lesson = Book::Lesson.new(@b22)
      assert_match /\AStudents should record/, lesson.questions
      assert_match /tissue of the organism.\)\z/, lesson.questions

      lesson = Book::Lesson.new(@b30)
      assert_match /\AStudents should record/, lesson.questions
      assert_match /and many other diseases\?\z/, lesson.questions

      lesson = Book::Lesson.new(@c5)
      assert_match /\AMake paper-fold books/, lesson.questions
      assert_match /engine and more fuel\?\z/, lesson.questions

      lesson = Book::Lesson.new(@c10)
      assert_match /\AStudents should record/, lesson.questions
      assert_match /speed of the vehicle\?\z/, lesson.questions

      lesson = Book::Lesson.new(@d5)
      assert_match /\AHave students make/, lesson.questions
      assert_match /rotation is not changing\?\z/, lesson.questions

      lesson = Book::Lesson.new(@d14)
      assert_match /\AHave students record/, lesson.questions
      assert_match /predominant flora and fauna of each\.\z/, lesson.questions
    end

    test "#support" do
      lesson = Book::Lesson.new(@a2)
      assert_match /\AIn the kitchen, bathroom/, lesson.support
      assert_match /solid, or a combination\?\z/, lesson.support

      lesson = Book::Lesson.new(@a18)
      assert_match /\AWith supervision, facilitate/, lesson.support
      assert_match /placement is significant\.\z/, lesson.support

      lesson = Book::Lesson.new(@a22)
      assert_match /\AFacilitate children measuring/, lesson.support
      assert_match /chemists behind such products\.\z/, lesson.support

      lesson = Book::Lesson.new(@b22)
      assert_match /\AIn conjunction with growing/, lesson.support
      assert_match /aspect of this lesson\.\z/, lesson.support

      lesson = Book::Lesson.new(@b30)
      assert_match /\AFacilitate children in making/, lesson.support
      assert_match /of the immune system\.\z/, lesson.support

      lesson = Book::Lesson.new(@c5)
      assert_match /\AIn the routines of/, lesson.support
      assert_match /energy and inertia\.\z/, lesson.support

      lesson = Book::Lesson.new(@c10)
      assert_match /\AThrough everyday experience,/, lesson.support
      assert_match /Flywheels are a prime example\.\z/, lesson.support

      lesson = Book::Lesson.new(@d5)
      assert_match /\ADraw children’s attention/, lesson.support
      assert_match /orbit rotation period\)\.\z/, lesson.support

      lesson = Book::Lesson.new(@d14)
      assert_match /\AFacilitate children making observations/, lesson.support
      assert_match /constitutes an unique ecosystem\.\z/, lesson.support
    end

    test "#connections" do
      lesson = Book::Lesson.new(@a2)
      assert_match /\ARecognizing that everything/, lesson.connections
      assert_match /achieving NGSS: 5-ESS2-1\.\z/, lesson.connections

      lesson = Book::Lesson.new(@a18)
      assert_match /\AConvection currents play/, lesson.connections
      assert_match /other standards as well\.\z/, lesson.connections

      lesson = Book::Lesson.new(@a22)
      assert_match /\AThe concepts of chemistry/, lesson.connections
      assert_match /Chemical Reactions and Energy\.\z/, lesson.connections

      lesson = Book::Lesson.new(@b22)
      assert_match /\AHow cell division, growth,/, lesson.connections
      assert_match /are: a, b, d, and g\.\z/, lesson.connections

      lesson = Book::Lesson.new(@b30)
      assert_match /\ABeyond providing a general/, lesson.connections
      assert_match /pathology, and related fields\.\z/, lesson.connections

      lesson = Book::Lesson.new(@c5)
      assert_nil lesson.connections

      lesson = Book::Lesson.new(@c10)
      assert_match /\AMomentum is a key physical/, lesson.connections
      assert_match /lesson are: a, b, c, d, e, f, and h\.\z/, lesson.connections

      lesson = Book::Lesson.new(@d5)
      assert_match /\ATime is such an integral/, lesson.connections
      assert_match /2-ESS1-1; and 5-ESS1-2\.\z/, lesson.connections

      lesson = Book::Lesson.new(@d14)
      assert_match /\ALesson D-15, The Solar System/, lesson.connections
      assert_match /observed in different locations\z/, lesson.connections
    end

    test "#books" do
      lesson = Book::Lesson.new(@a2)
      assert_match /\ACurry, Don L\.  What Is Matter\?/, lesson.books
      assert_match /Matter \(Early Bird\)\. Lerner,\z/, lesson.books

      lesson = Book::Lesson.new(@a18)
      assert_match /\AHakim, Joy\. The Story of Science/, lesson.books
      assert_match /Children’s Press, 2003\.\z/, lesson.books

      lesson = Book::Lesson.new(@a22)
      assert_match /\AOxlade, Chris\.  Acids and Bases/, lesson.books
      assert_match /Atoms: Unraveling Their Nature\.\z/, lesson.books

      lesson = Book::Lesson.new(@b22)
      assert_match /\ABang, Molly\. Living Sunlight/, lesson.books
      assert_match /from Capstone Press\.\z/, lesson.books

      lesson = Book::Lesson.new(@b30)
      assert_match /\AByrnie, Faith Hickman./, lesson.books
      assert_match /Science\)\. Enslow, 2001\.\z/, lesson.books

      lesson = Book::Lesson.new(@c5)
      assert_match /\ABradley, Kimberly/, lesson.books
      assert_match /Rourke, 2007\.\z/, lesson.books

      lesson = Book::Lesson.new(@c10)
      assert_match /\AGraham, John, Forces and Motion/, lesson.books
      assert_match /\(Exploratorium\)\. Wiley, 2008\.\z/, lesson.books

      lesson = Book::Lesson.new(@d5)
      assert_match /\ABailey, Jacqui and Matthew/, lesson.books
      assert_match /Over and Over\.  Harp\z/, lesson.books

      lesson = Book::Lesson.new(@d14)
      assert_match /\ALegault, Thierry and Serge Brunier/, lesson.books
      assert_match /that the effect is the same\.\z/, lesson.books
    end

  end

end
