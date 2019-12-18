require 'test_helper'

class UserHistoryControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_history_index_url
    assert_response :success
  end

end
