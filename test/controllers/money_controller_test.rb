require 'test_helper'

class MoneyControllerTest < ActionDispatch::IntegrationTest
  test "should get bank_statement" do
    get money_bank_statement_url
    assert_response :success
  end

end
