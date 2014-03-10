require 'test_helper'

class MaterialTest < ActiveSupport::TestCase
  test "validates presence of name" do
    material = Material.new
    assert !material.valid?
    assert material.errors[:name].include? "can't be blank"
  end

  test "validates presence of original_name" do
    material = Material.new
    assert !material.valid?
    assert material.errors[:original_name].include? "can't be blank"
  end
end
