require "test_helper"
require "topic_slug"

class TopicSlugTest < ActiveSupport::TestCase

  test "#slug downcases" do
    assert_equal "a-2", TopicSlug.new("A-2").slug
  end

  test "#slug removes '/'" do
    assert_equal "ab-2", TopicSlug.new("A/B-2").slug
  end

end
