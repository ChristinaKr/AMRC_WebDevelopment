require 'test_helper'

class UploadGrantDataControllerTest < ActionDispatch::IntegrationTest
  test "should get upload_grant_data" do
    get upload_grant_data_upload_grant_data_url
    assert_response :success
  end

end
