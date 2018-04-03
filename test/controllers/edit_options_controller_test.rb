require 'test_helper'

class EditOptionsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit_options_dashbaord" do
    get edit_options_edit_options_dashbaord_url
    assert_response :success
  end

end
