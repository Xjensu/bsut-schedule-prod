require "test_helper"

class FacultyControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get faculty_index_url
    assert_response :success
  end

  test "should get new" do
    get faculty_new_url
    assert_response :success
  end

  test "should get create" do
    get faculty_create_url
    assert_response :success
  end

  test "should get edit" do
    get faculty_edit_url
    assert_response :success
  end

  test "should get update" do
    get faculty_update_url
    assert_response :success
  end

  test "should get delete" do
    get faculty_delete_url
    assert_response :success
  end
end
