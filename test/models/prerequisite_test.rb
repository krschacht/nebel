require "test_helper"

class PrerequisiteTest < ActiveSupport::TestCase

  test "::all_prerequisite_topic_ids_for_topic_id returns direct prerequisite topic IDs" do
    Prerequisite.create! topic_id: 1, prerequisite_topic_id: 5
    Prerequisite.create! topic_id: 1, prerequisite_topic_id: 6
    Prerequisite.create! topic_id: 1, prerequisite_topic_id: 7

    assert_equal [5, 6, 7], Prerequisite.all_prerequisite_topic_ids_for_topic_id(1)
  end

  test "::all_prerequisite_topic_ids_for_topic_id returns indirect prerequisite topic IDs" do
    Prerequisite.create! topic_id: 1, prerequisite_topic_id: 2
    Prerequisite.create! topic_id: 2, prerequisite_topic_id: 3
    Prerequisite.create! topic_id: 3, prerequisite_topic_id: 4

    assert_equal [2, 3, 4], Prerequisite.all_prerequisite_topic_ids_for_topic_id(1)
  end

  test "::all_prerequisite_topic_ids_for_topic_id handles circular dependencies" do
    Prerequisite.create! topic_id: 1, prerequisite_topic_id: 2
    Prerequisite.create! topic_id: 2, prerequisite_topic_id: 1

    assert_equal [2, 1], Prerequisite.all_prerequisite_topic_ids_for_topic_id(1)
  end

  test "::all_prerequisite_topic_ids_for_topic_id only calls ::all once" do
    prerequisite_a = Prerequisite.create! topic_id: 1, prerequisite_topic_id: 2
    prerequisite_b = Prerequisite.create! topic_id: 2, prerequisite_topic_id: 3
    prerequisite_c = Prerequisite.create! topic_id: 3, prerequisite_topic_id: 4

    Prerequisite.expects(:all).once.returns([prerequisite_a, prerequisite_b, prerequisite_c])

    Prerequisite.all_prerequisite_topic_ids_for_topic_id(1)
  end

end
