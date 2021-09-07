require "test_helper"

class UpdatedControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get updated_index_url
    assert_response :success
  end
end
