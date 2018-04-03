require 'test_helper'

class AddNewCharityControllerTest < ActionDispatch::IntegrationTest
  test "should get add_new_charity" do
    get add_new_charity_add_new_charity_url
    assert_response :success
  end

end
