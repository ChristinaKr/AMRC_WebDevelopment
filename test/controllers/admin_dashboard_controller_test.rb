require 'test_helper'

class AdminDashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get dashboard" do
    get admin_dashboard_dashboard_url
    assert_response :success
  end

end
