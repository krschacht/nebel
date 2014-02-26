require "book"

class BookImporter

  def initialize(lesson_paths)
    @lesson_paths = lesson_paths
  end

  def import
    create_topic_and_exercises
    create_prerequisites
  end

private

  def create_topic_and_exercises
    book_lessons.each do |book_lesson|
      topic_factory    = TopicFactory.new(book_lesson)
      exercise_factory = ExerciseFactory.new(book_lesson)

      topic     = topic_factory.topic
      exercises = exercise_factory.exercises

      topic.subject_id = 1

      if topic.save!
        exercises.each do |exercise|
          exercise.topic_id = topic.id

          exercise.save!
        end
      end
    end
  end

  def create_prerequisites
    book_lessons.each do |book_lesson|
      topic                     = Topic.find_by_code(book_lesson.full_lesson_code)
      prerequisite_factory      = PrerequisiteFactory.new(book_lesson)
      prerequisite_topic_codes  = prerequisite_factory.topic_codes
      prerequisite_topics       = Topic.where(code: prerequisite_topic_codes)
      topic.prerequisite_topics = prerequisite_topics
    end
  end

  def book_lessons
    @book_lessons ||= @lesson_paths.map do |lesson_path|
      Book::Lesson.new(lesson_path)
    end
  end

end
