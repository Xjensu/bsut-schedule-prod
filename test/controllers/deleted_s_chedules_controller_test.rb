require "test_helper"

class DeletedSChedulesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get deleted_s_chedules_create_url
    assert_response :success
  end

  test "should get destroy" do
    get deleted_s_chedules_destroy_url
    assert_response :success
  end
end
