require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:user_one)
    sign_in @user
  end

  test "should get home" do
    get root_path
    assert_response :success
  end
end
