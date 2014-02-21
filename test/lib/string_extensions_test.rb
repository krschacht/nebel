require 'test_helper'

class StringExtensionsTest < ActiveSupport::TestCase

  test "return nil if blank" do
    assert_nil "".clean
  end

  test "remove leading whitespace" do
    assert_equal "foo", " foo".clean
  end

  test "remove leading line breaks" do
    assert_equal "foo", "\nfoo".clean
  end

  test "remove trailing whitespace" do
    assert_equal "foo", "foo ".clean
  end

  test "remove trailing line breaks" do
    assert_equal "foo", "foo\n".clean
  end

  test "replace line separator character with line break" do
    assert_equal "foo\nbar", "foo\u2028bar".clean
  end

end
