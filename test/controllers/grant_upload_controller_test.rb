require 'test_helper'

class GrantUploadControllerTest < ActionDispatch::IntegrationTest
  test "should get grant_data" do
    get grant_upload_grant_data_url
    assert_response :success
  end

end
