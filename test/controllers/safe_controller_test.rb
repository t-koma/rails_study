require 'test_helper'

class SafeControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get safe_edit_url
    assert_response :success
  end

end
