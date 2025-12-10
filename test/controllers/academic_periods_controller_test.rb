require "test_helper"

class AcademicPeriodsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get academic_periods_new_url
    assert_response :success
  end

  test "should get create" do
    get academic_periods_create_url
    assert_response :success
  end

  test "should get edit" do
    get academic_periods_edit_url
    assert_response :success
  end

  test "should get update" do
    get academic_periods_update_url
    assert_response :success
  end

  test "should get destroy" do
    get academic_periods_destroy_url
    assert_response :success
  end
end
