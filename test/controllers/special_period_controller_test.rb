require "test_helper"

class SpecialPeriodControllerTest < ActionDispatch::IntegrationTest
  test "should get find" do
    get special_period_find_url
    assert_response :success
  end

  test "should get new" do
    get special_period_new_url
    assert_response :success
  end

  test "should get create" do
    get special_period_create_url
    assert_response :success
  end

  test "should get edit" do
    get special_period_edit_url
    assert_response :success
  end

  test "should get update" do
    get special_period_update_url
    assert_response :success
  end

  test "should get destroy" do
    get special_period_destroy_url
    assert_response :success
  end
end
