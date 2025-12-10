require "test_helper"

class TransferSchedulesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get transfer_schedules_index_url
    assert_response :success
  end
end
