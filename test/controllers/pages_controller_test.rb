require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers  # Devise のテストヘルパーを追加

  def setup
    @user = users(:one)  # fixtures のユーザーを読み込む
    sign_in @user        # ログイン状態にする
  end

  test "should get home" do
    get root_path
    assert_response :success
  end
end
