require 'test_helper'

class GrantsManuallyControllerTest < ActionDispatch::IntegrationTest
  test "should get grants_manually" do
    get grants_manually_grants_manually_url
    assert_response :success
  end

end
