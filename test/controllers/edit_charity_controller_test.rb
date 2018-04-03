require 'test_helper'

class EditCharityControllerTest < ActionDispatch::IntegrationTest
  test "should get edit_charity" do
    get edit_charity_edit_charity_url
    assert_response :success
  end

end
