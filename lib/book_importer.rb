require "book"

class BookImporter

  def initialize(lesson_paths)
    @lesson_paths = lesson_paths
  end

  def import
    Rails.logger.tagged "Book Import" do
      create_topics_and_exercises
      create_prerequisites
      create_materials_and_requisitions
    end
  end

private

  def create_topics_and_exercises
    Rails.logger.info "Creating topics and exercises"

    subjects = Subject.all.to_a

    book_lessons.each do |book_lesson|
      raise "Book lesson missing subject code" if book_lesson.subject_code.nil?

      topic_factory    = TopicFactory.new(book_lesson)
      exercise_factory = ExerciseFactory.new(book_lesson)

      subject = subjects.find { |s| s.code == book_lesson.subject_code }
      raise "Subject not found with code '#{book_lesson.subject_code}'" if subject.nil?

      topic = topic_factory.topic(subject)
      Rails.logger.info "Saving topic #{topic.code} (#{topic.new_record? ? 'new' : topic.id})"
      topic.save!

      exercises = exercise_factory.exercises(topic)
      exercises.each do |exercise|
        Rails.logger.info "Saving exercise Part #{exercise.part} (#{exercise.new_record? ? 'new' : exercise.id})"
        exercise.save
      end
    end
  end

  def create_prerequisites
    Rails.logger.info "Creating prerequisites"

    book_lessons.each do |book_lesson|
      topic                    = Topic.find_by_code(book_lesson.full_lesson_code)
      prerequisite_factory     = PrerequisiteFactory.new(book_lesson)
      prerequisite_topic_codes = prerequisite_factory.topic_codes
      prerequisite_topics      = Topic.where(code: prerequisite_topic_codes)

      Rails.logger.info "Saving prerequisites (x#{prerequisite_topics.size}) for #{topic.slug}"
      topic.prerequisite_topics = prerequisite_topics
    end
  end

  def create_materials_and_requisitions
    Rails.logger.info "Creating materials and requisitions"

    book_lessons.each do |book_lesson|
      topic = Topic.find_by_code(book_lesson.full_lesson_code)

      topic.exercises.each do |exercise|
        materials_factory = MaterialFactory.new(book_lesson)

        materials = materials_factory.materials(exercise)

        Rails.logger.info "Saving materials (x#{materials.size}) for #{topic.slug}/part-#{exercise.part}"
        materials.each do |material|
          material.save
          Requisition.find_or_create_by!({
            exercise_id: exercise.id, material_id: material.id
          })
        end
      end
    end
  end

  def book_lessons
    @book_lessons ||= @lesson_paths.map do |lesson_path|
      Book::Lesson.new(lesson_path)
    end
  end

end
