require "test_helper"

class StudentGroupControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get student_group_index_url
    assert_response :success
  end

  test "should get new" do
    get student_group_new_url
    assert_response :success
  end

  test "should get create" do
    get student_group_create_url
    assert_response :success
  end

  test "should get edit" do
    get student_group_edit_url
    assert_response :success
  end

  test "should get update" do
    get student_group_update_url
    assert_response :success
  end

  test "should get delete" do
    get student_group_delete_url
    assert_response :success
  end
end
