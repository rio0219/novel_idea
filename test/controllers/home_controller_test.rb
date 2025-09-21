require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:user_one)
    sign_in @user
  end

  test "should get index" do
    get home_index_path
    assert_response :success
  end
end
