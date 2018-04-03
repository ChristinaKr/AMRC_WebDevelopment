require 'test_helper'

class ReportsOptionsControllerTest < ActionDispatch::IntegrationTest
  test "should get reports_options" do
    get reports_options_reports_options_url
    assert_response :success
  end

end
