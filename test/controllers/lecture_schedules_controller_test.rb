require "test_helper"

class LectureSchedulesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get lecture_schedules_index_url
    assert_response :success
  end

  test "should get new" do
    get lecture_schedules_new_url
    assert_response :success
  end

  test "should get create" do
    get lecture_schedules_create_url
    assert_response :success
  end

  test "should get edit" do
    get lecture_schedules_edit_url
    assert_response :success
  end

  test "should get update" do
    get lecture_schedules_update_url
    assert_response :success
  end

  test "should get destroy" do
    get lecture_schedules_destroy_url
    assert_response :success
  end
end
