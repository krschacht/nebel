require 'test_helper'

class SubjectTest < ActiveSupport::TestCase
  test "validates presence of code" do
    subject = Subject.new
    assert !subject.valid?
    assert subject.errors[:code].include? "can't be blank"
  end

  test "validates presence of name" do
    subject = Subject.new
    assert !subject.valid?
    assert subject.errors[:name].include? "can't be blank"
  end
end
