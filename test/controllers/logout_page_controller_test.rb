require 'test_helper'

class LogoutPageControllerTest < ActionDispatch::IntegrationTest
  test "should get logout_page" do
    get logout_page_logout_page_url
    assert_response :success
  end

end
