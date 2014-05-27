require "book"
require "topic_slug"

module MarkdownHelper

  def markdown(string)
    return nil if string.nil?
    result = renderer.render(string)
    result.gsub! Book::TOPIC_CODE_PATTERN do |topic_code|
      link_to(topic_code, canonical_topic_path(TopicSlug.new(topic_code).slug))
    end
    result.gsub!  /\(Google: (.*)\)/ do |match|
      "(Google: <a href='http://google.com/search?q=#{ CGI.escape($1) }' target='_blank'>#{ $1 }</a>)"
    end

    result.html_safe
  end

private

  def renderer
    @renderer ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, {
      no_intra_empasis: true,
      autolink: true,
      tables: false,
      fenced_code_blocks: true,
      disable_indented_code_blocks: true,
      strikethrough: false,
      space_after_headers: true,
      underline: true,
      quote: false,
      footnotes: false
    })
  end

end
