require "test_helper"

class Api::V1::TechnologiesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_technologies_index_url
    assert_response :success
  end

  test "should get show" do
    get api_v1_technologies_show_url
    assert_response :success
  end
end
