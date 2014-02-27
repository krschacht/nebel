require "test_helper"

class TopicFactoryTest < ActiveSupport::TestCase

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

  test "#topics" do
    topic = TopicFactory.new(@a2).topic
    assert_equal 2, topic.order
    assert_equal "A-2", topic.code
    assert_equal "Solids, Liquids, and Gases and Change With Temperature", topic.name
    assert_match /\AIn this lesson students/, topic.overview
    assert_match /temperature; others don’t\.\z/, topic.overview
    assert_match /\ABeyond the progression/, topic.context
    assert_match /other sciences as well\.\z/, topic.context
    assert_match /\AStudents who demonstrate/, topic.objectives
    assert_match /and don’t occupy space\.\z/, topic.objectives
    assert_match /\AIntroduce this exercise/, topic.teachable_moments
    assert_match /at any convenient time\.\z/, topic.teachable_moments
    assert_match /\AStudents should make one/, topic.questions
    assert_match /matter\. What are they\?\z/, topic.questions
    assert_match /\AIn the kitchen, bathroom/, topic.parents
    assert_match /or solid, or a combination\?\z/, topic.parents
    assert_match /\ARecognizing that everything/, topic.connections
    assert_match /achieving NGSS: 5-ESS2-1\.\z/, topic.connections
    assert_match /\ACurry, Don L\.  What Is Matter\?/, topic.books
    assert_match /Matter \(Early Bird\)\. Lerner,\z/, topic.books

    topic = TopicFactory.new(@c5).topic
    assert_equal 5, topic.order
    assert_equal "C-5", topic.code
    assert_equal "Inertia", topic.name
    assert_match /\AThrough observation and analysis/, topic.overview
    assert_match /energy inputs and outputs.\z/, topic.overview
    assert_match /\AInertia’s designation as the/, topic.context
    assert_match /lessons of this thread\.\z/, topic.context
    assert_match /\AThrough this exercise, students/, topic.objectives
    assert_match /materialize out of nothing\.\z/, topic.objectives
    assert_match /\AUse a demonstration of/, topic.teachable_moments
    assert_match /more of the games described\.\z/, topic.teachable_moments
    assert_match /\AMake paper-fold books or record/, topic.questions
    assert_match /bigger engine and more fuel\?\z/, topic.questions
    assert_match /\AIn the routines of everyday life/, topic.parents
    assert_match /between energy and inertia\.\z/, topic.parents
    assert_nil topic.connections
    assert_match /\ABradley, Kimberly Brubaker\./, topic.books
    assert_match /Forces\)\.  Rourke, 2007\.\z/, topic.books

    topic = TopicFactory.new(@d5).topic
    assert_equal 5, topic.order
    assert_equal "D-5", topic.code
    assert_equal "Time and the Earth’s Turning", topic.name
    assert_match /\AIn this lesson, students/, topic.overview
    assert_match /use them in telling time\.\z/, topic.overview
    assert_match /\AIn this lesson, students/, topic.context
    assert_match /system and the heavens above\.\z/, topic.context
    assert_match /\AStudents who demonstrate/, topic.objectives
    assert_match /and what aspects remain constant\.\z/, topic.objectives
    assert_match /\AThis lesson can be inserted/, topic.teachable_moments
    assert_match /period and note the shift\.\z/, topic.teachable_moments
    assert_match /\AHave students make paper-fold/, topic.questions
    assert_match /Earth’s rotation is not changing\?\z/, topic.questions
    assert_match /\ADraw children’s attention/, topic.parents
    assert_match /orbit rotation period\)\.\z/, topic.parents
    assert_match /\ATime is such an integral aspect/, topic.connections
    assert_match /2-ESS1-1; and 5-ESS1-2\.\z/, topic.connections
    assert_match /\ABailey, Jacqui and Matthew/, topic.books
    assert_match /Over and Over\.  Harp\z/, topic.books

    topic = TopicFactory.new(@a18).topic
    assert_equal 18, topic.order
    assert_equal "A-18", topic.code
    assert_equal "Convection Currents: Observation and Interpretation", topic.name
    assert_match /\AIn this lesson, students will use/, topic.overview
    assert_match /heating by passive solar energy\.\z/, topic.overview
    assert_match /\AThis lesson makes a bridge/, topic.context
    assert_match /weather patterns around the globe\.\z/, topic.context
    assert_match /\AStudents who demonstrate understanding/, topic.objectives
    assert_match /oceans and in the atmosphere\.\z/, topic.objectives
    assert_match /\AHaving students help set up/, topic.teachable_moments
    assert_match /create its own teachable moment.\z/, topic.teachable_moments
    assert_match /\AStudents should record in their/, topic.questions
    assert_match /Google: passive solar design\.\z/, topic.questions
    assert_match /\AWith supervision, facilitate children/, topic.parents
    assert_match /why this placement is significant.\z/, topic.parents
    assert_match /\AConvection currents play a role/, topic.connections
    assert_match /many other standards as well\.\z/, topic.connections
    assert_match /\AHakim, Joy\. The Story of Science/, topic.books
    assert_match /Children’s Press, 2003\.\z/, topic.books

    topic = TopicFactory.new(@b22).topic
    assert_equal 22, topic.order
    assert_equal "B-22", topic.code
    assert_equal "The Life of Plants II: How a Plant Grows Its Parts", topic.name
    assert_match /\ADovetailing with growing a small/, topic.overview
    assert_match /e\.g\., a leaf versus a flower\.\z/, topic.overview
    assert_match /\AIn this lesson students/, topic.context
    assert_match /determining answers from collected data\.\z/, topic.context
    assert_match /\AStudents who demonstrate understanding/, topic.objectives
    assert_match /meristematic cells of the same plant\.\z/, topic.objectives
    assert_match /\AGrowing and maintaining garden/, topic.teachable_moments
    assert_match /into the lesson\(s\) at hand\.\z/, topic.teachable_moments
    assert_match /\AStudents should record/, topic.questions
    assert_match /tissue of the organism\.\)\z/, topic.questions
    assert_match /\AIn conjunction with growing/, topic.parents
    assert_match /any aspect of this lesson.\z/, topic.parents
    assert_match /\AHow cell division, growth,/, topic.connections
    assert_match /the fore are: a, b, d, and g\.\z/, topic.connections
    assert_match /\ABang, Molly\. Living Sunlight:/, topic.books
    assert_match /series from Capstone Press\.\z/, topic.books

    topic = TopicFactory.new(@c10).topic
    assert_equal 10, topic.order
    assert_equal "C-10", topic.code
    assert_equal "Movement Energy and Momentum", topic.name
    assert_match /\AFollowing a review of the phenomenon/, topic.overview
    assert_match /calculations may be included\.\z/, topic.overview
    assert_match /\ABuilding on students’ introduction/, topic.context
    assert_match /weather, or space flight\.\z/, topic.context
    assert_match /\AStudents who demonstrate/, topic.objectives
    assert_match /measurement of kinetic energy\.\z/, topic.objectives
    assert_match /\AAct out pushing, kicking,/, topic.teachable_moments
    assert_match /the activities of everyday life\.\z/, topic.teachable_moments
    assert_match /\AStudents should record in their/, topic.questions
    assert_match /the speed of the vehicle\?\z/, topic.questions
    assert_match /\AThrough everyday experience,/, topic.parents
    assert_match /Flywheels are a prime example\.\z/, topic.parents
    assert_match /\AMomentum is a key physical/, topic.connections
    assert_match /are: a, b, c, d, e, f, and h\.\z/, topic.connections
    assert_match /\AGraham, John, Forces and Motion/, topic.books
    assert_match /\(Exploratorium\)\. Wiley, 2008\.\z/, topic.books

    topic = TopicFactory.new(@a22).topic
    assert_equal 22, topic.order
    assert_equal "A-22", topic.code
    assert_equal "Concepts of Chemistry V Acids and Bases", topic.name
    assert_match /\AStudents will go beyond/, topic.overview
    assert_match /opportunities for careers in chemistry\.\z/, topic.overview
    assert_nil topic.context
    assert_match /\AThrough this exercise, students/, topic.objectives
    assert_match /future careers in chemistry\.\z/, topic.objectives
    assert_match /\ADemonstrating beet or red cabbage/, topic.teachable_moments
    assert_match /reaction will attract attention\.\z/, topic.teachable_moments
    assert_match /\AStudents should record in/, topic.questions
    assert_match /contribute to our lives in the future\?\z/, topic.questions
    assert_match /\AFacilitate children measuring/, topic.parents
    assert_match /of chemists behind such products\.\z/, topic.parents
    assert_match /\AThe concepts of chemistry/, topic.connections
    assert_match /Chemical Reactions and Energy\.\z/, topic.connections
    assert_match /\AOxlade, Chris\.  Acids and Bases/, topic.books
    assert_match /Atoms: Unraveling Their Nature\.\z/, topic.books

    topic = TopicFactory.new(@b30).topic
    assert_equal 30, topic.order
    assert_equal "B-30", topic.code
    assert_equal "Viruses: Their Attack Nature, Attack, and Our Defense", topic.name
    assert_match /\AStarting with an overview/, topic.overview
    assert_match /control, and cure of diseases\.\z/, topic.overview
    assert_nil topic.context
    assert_match /\AThrough this exercise, students/, topic.objectives
    assert_match /control of the diseases they cause\.\z/, topic.objectives
    assert_match /\AShowing pictures, reading stories,/, topic.teachable_moments
    assert_match /create its own teachable moments.\z/, topic.teachable_moments
    assert_match /\AStudents should record in their/, topic.questions
    assert_match /AIDS, and many other diseases\?\z/, topic.questions
    assert_match /\AFacilitate children in making/, topic.parents
    assert_match /efficacy of the immune system\.\z/, topic.parents
    assert_match /\ABeyond providing a general/, topic.connections
    assert_match /pathology, and related fields\.\z/, topic.connections
    assert_match /\AByrnie, Faith Hickman\. 101/, topic.books
    assert_match /Minds of Science\)\. Enslow, 2001\.\z/, topic.books

    topic = TopicFactory.new(@d14).topic
    assert_equal 14, topic.order
    assert_equal "D-14", topic.code
    assert_equal "The Moon and Its Phases, and Tides", topic.name
    assert_match /\AWhile people can hardly/, topic.overview
    assert_match /importance of intertidal zones\.\z/, topic.overview
    assert_nil topic.context
    assert_match /\AThrough this exercise, students/, topic.objectives
    assert_match /with the phase of the moon.\z/, topic.objectives
    assert_match /\AAt any time there is a clear/, topic.teachable_moments
    assert_match /it in a more systematic way\.\z/, topic.teachable_moments
    assert_match /\AHave students record in/, topic.questions
    assert_match /flora and fauna of each\.\z/, topic.questions
    assert_match /\AFacilitate children making observations/, topic.parents
    assert_match /it constitutes an unique ecosystem\.\z/, topic.parents
    assert_match /\ALesson D-15, The Solar/, topic.connections
    assert_match /observed in different locations\z/, topic.connections
    assert_match /\ALegault, Thierry and Serge Brunier\./, topic.books
    assert_match /that the effect is the same\.\z/, topic.books
  end

end
