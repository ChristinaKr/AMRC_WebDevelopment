require 'test_helper'

class GrantsDataLpControllerTest < ActionDispatch::IntegrationTest
  test "should get grants_data_lp" do
    get grants_data_lp_grants_data_lp_url
    assert_response :success
  end

end
