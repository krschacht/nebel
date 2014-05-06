require 'test_helper'

class MarkdownHelperTest < ActionView::TestCase

  test "#markdown returns nil if given nil" do
    assert_nil markdown(nil)
  end

  test "#markdown renders markdown from a string" do
    string = <<-EOS.strip_heredoc
      # Heading 1
      ## Heading 2
      ### Heading 3

      1. Number 1
      2. Number 2
      3. Number 3

      * Bullet 1
      * Bullet 2
      * Bullet 3

      *Lorem* _ipsum_ http://example.com.
    EOS

    html = <<-EOS.strip_heredoc
      <h1>Heading 1</h1>

      <h2>Heading 2</h2>

      <h3>Heading 3</h3>

      <ol>
      <li>Number 1</li>
      <li>Number 2</li>
      <li>Number 3</li>
      </ol>

      <ul>
      <li>Bullet 1</li>
      <li>Bullet 2</li>
      <li>Bullet 3</li>
      </ul>

      <p><em>Lorem</em> <u>ipsum</u> <a href="http://example.com">http://example.com</a>.</p>
    EOS

    assert_equal html, markdown(string)
  end

  test "#markdown inserts links to lessons" do
    assert_equal "<p>Lesson #{link_to("B-21", canonical_topic_path("b-21"))}</p>\n", markdown("Lesson B-21")
    assert_equal "<p>Lesson #{link_to("A/B-1", canonical_topic_path("ab-1"))}</p>\n", markdown("Lesson A/B-1")
    assert_equal "<p>Lesson #{link_to("B-13", canonical_topic_path("b-13"))} and #{link_to("B-14", canonical_topic_path("b-14"))}</p>\n", markdown("Lesson B-13 and B-14")
    assert_equal "<p>Lesson #{link_to("C-3A", canonical_topic_path("c-3a"))}</p>\n", markdown("Lesson C-3A")
  end

end
