require "net/http"

class Book

  class Lesson

    attr_reader :text

    def initialize(path_or_text)
      @text = File.exists?(path_or_text) ? File.read(path_or_text) : path_or_text
    end

    def overview
      result   = @text[/overview:(.*)^.*progress(ion)? of learning:/mi, 1]
      result ||= @text[/overview:(.*)time required:/mi, 1]
      clean result
    end

    def position
      result   = @text[/progress of learning:(.*)time required:/mi, 1]
      result ||= @text[/progression of learning:(.*)time required:/mi, 1]
      clean result
    end

    def time_required
      result   = @text[/time required:(.*)objectives:/mi, 1]
      result ||= @text[/time required:(.*)^outcomes:/mi, 1]
      result ||= @text[/time required:(.*)^practices:/mi, 1]
      clean result
    end

    def objectives
      clean @text[/(practices|outcomes|objectives):(.*)required background:/mi, 2]
    end

    def required_background
      clean @text[/required background:(.*)materials:/mi, 1]
    end

    def materials
      clean @text[/materials:(.*)teachable moments:/mi, 1]
    end

    def teachable_moments
      clean @text[/teachable moments:(.*)methods and procedures:/mi, 1]
    end

    def methods_and_procedures
      clean @text[/methods and procedures:(.*)^questions.*:/mi, 1]
    end

    def questions
      clean @text[/assess learning:(.*)to parents and.*:/mi, 1]
    end

    def support
      result   = @text[/providing support:(.*)re: framework.*ngss/mi, 1]
      result ||= @text[/providing support:(.*)connections to other topics/mi, 1]
      result ||= @text[/providing support:(.*)books for correlated reading:/mi, 1]
      clean result
    end

    def ngss
      clean @text[/^re:.*principles and.*\(?ngss\)?\s*$(.*)books for correlated reading:/mi, 1]
    end

    def connections
      clean @text[/follow-up to higher levels:(.*)books for correlated reading:/mi, 1]
    end

    def books
      clean @text[/correlated reading:(.*)/mi, 1]
    end

  private

    def clean(string)
      return nil if string.blank?
      string.gsub(/\u2028/, "").gsub(/(\A(\n|\s)*|(\n|\s)*\z)/, "")
    end

  end

end
