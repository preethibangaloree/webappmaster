require "test_helper"

class DataControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get data_create_url
    assert_response :success
  end

  test "should get update" do
    get data_update_url
    assert_response :success
  end
end
