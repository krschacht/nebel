module MarkdownHelper

  def markdown(string)
    return nil if string.nil?
    renderer.render(string).html_safe
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
