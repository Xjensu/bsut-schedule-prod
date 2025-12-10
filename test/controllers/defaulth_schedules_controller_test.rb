require "test_helper"

class DefaulthSchedulesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get defaulth_schedules_index_url
    assert_response :success
  end

  test "should get new" do
    get defaulth_schedules_new_url
    assert_response :success
  end

  test "should get create" do
    get defaulth_schedules_create_url
    assert_response :success
  end

  test "should get edit" do
    get defaulth_schedules_edit_url
    assert_response :success
  end

  test "should get update" do
    get defaulth_schedules_update_url
    assert_response :success
  end

  test "should get destroy" do
    get defaulth_schedules_destroy_url
    assert_response :success
  end

  test "should get show" do
    get defaulth_schedules_show_url
    assert_response :success
  end
end
