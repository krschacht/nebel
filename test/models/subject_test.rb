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

  test "validates uniqueness of code" do
    subject = subjects(:a)
    duplicate_subject = Subject.new code: subject.code
    assert !duplicate_subject.valid?
    assert duplicate_subject.errors[:code].include? "has already been taken"
  end

  test "has many topics" do
    assert subjects(:a).topics.include? topics(:a3)
  end
end
