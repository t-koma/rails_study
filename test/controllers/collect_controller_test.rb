require 'test_helper'

class CollectControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get collect_index_url
    assert_response :success
  end

end
