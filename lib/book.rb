require "net/http"

class Book

  # http://rubular.com/r/N2ZDxweEjo
  TOPIC_CODE_PATTERN = /[ABCD]\/?-?[ABCD]?-\d{1,2}[ABCD]?/

  class Lesson

    attr_reader :text

    def initialize(path_or_text)
      @text = File.exists?(path_or_text) ? File.read(path_or_text) : path_or_text
    end

    def name
      result   = @text[/\A\s*Lesson\s[ABCD]-\d{1,2}\n(.*)Overview:/m, 1]
      result ||= @text[/\A\s*Lesson\s[ABCD]\/[ABCD]-\d{1,2}\n(.*)Overview:/m, 1]
      result ||= @text[/\A\s*Lesson\s[ABCD]-\d{1,2}[AB]{1}\n(.*)Overview:/m, 1]
      result   = result.split("\n\n").first
      result.clean
    end

    def full_lesson_code
      @text[/\A\s*Lesson\s(.*)\n/, 1]
    end

    def subject_code
      @text[/\A\s*Lesson\s([ABCD])/m, 1]
    end

    def number
      result   = @text[/\A\s*Lesson\s[ABCD]-(\d{1,2})\n.*Overview:/m, 1]
      result ||= @text[/\A\s*Lesson\s[ABCD]\/[ABCD]-(\d{1,2})\n.*Overview:/m, 1]
      result ||= @text[/\A\s*Lesson\s[ABCD]-(\d{1,2})[AB]{1}\n.*Overview:/m, 1]
      result.to_i
    end

    def overview
      result   = @text[/overview:(.*)^.*progress(ion)? of learning:/mi, 1]
      result ||= @text[/overview:(.*)time required:/mi, 1]
      result.try :clean
    end

    def position
      result   = @text[/progress of learning:(.*)time required:/mi, 1]
      result ||= @text[/progression of learning:(.*)time required:/mi, 1]
      result.try :clean
    end

    def time_required
      result   = @text[/time required:(.*)objectives:/mi, 1]
      result ||= @text[/time required:(.*)^outcomes:/mi, 1]
      result ||= @text[/time required:(.*)^practices:/mi, 1]
      result.try :clean
    end

    def objectives
      @text[/(practices|outcomes|objectives):(.*)required background:/mi, 2].try :clean
    end

    def required_background
      @text[/required background:(.*)materials:/mi, 1].try :clean
    end

    def materials
      @text[/materials:(.*)teachable moments:/mi, 1].try :clean
    end

    def teachable_moments
      @text[/teachable moments:(.*)methods and procedures:/mi, 1].try :clean
    end

    def methods_and_procedures
      result   = @text[/methods and procedures:(.*)^questions.*/mi, 1]
      result ||= @text[/methods and procedure:(.*)^questions.*/mi, 1]
      result.try :clean
    end

    def questions
      @text[/assess learning:(.*)to parents and.*:/mi, 1].try :clean
    end

    def support
      result   = @text[/providing support:(.*)re: framework.*ngss/mi, 1]
      result ||= @text[/providing support:(.*)connections to other topics/mi, 1]
      result ||= @text[/providing support:(.*)books for correlated reading:/mi, 1]
      result.try :clean
    end

    def connections
      result   = @text[/^re:.*principles and.*\(?ngss\)?\s*$(.*)books for correlated reading:/mi, 1]
      result ||= @text[/follow-up to higher levels:(.*)books for correlated reading:/mi, 1]
      result.try :clean
    end

    def books
      @text[/correlated reading:(.*)/mi, 1].try :clean
    end

  end

end
