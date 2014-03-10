require 'test_helper'

class RequisitionTest < ActiveSupport::TestCase
  test "quantity defaults to 1" do
    assert_equal 1, Requisition.new.quantity
  end
end
