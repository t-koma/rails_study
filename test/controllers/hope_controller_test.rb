require 'test_helper'

class HopeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get hope_index_url
    assert_response :success
  end

end
