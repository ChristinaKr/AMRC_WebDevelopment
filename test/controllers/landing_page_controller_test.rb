require 'test_helper'

class LandingPageControllerTest < ActionDispatch::IntegrationTest
  test "should get landingPage" do
    get landing_page_landingPage_url
    assert_response :success
  end

end
