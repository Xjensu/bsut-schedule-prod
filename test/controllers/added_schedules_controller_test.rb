require "test_helper"

class AddedSchedulesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get added_schedules_create_url
    assert_response :success
  end

  test "should get destroy" do
    get added_schedules_destroy_url
    assert_response :success
  end
end
