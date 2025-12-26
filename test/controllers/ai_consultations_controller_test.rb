require "test_helper"

class AiConsultationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:user_one)  # fixtures/users.yml の user_one を使う
    sign_in @user
  end

  test "should get index" do
    get ai_consultations_url
    assert_response :success
  end

  test "should create consultation" do
    assert_difference("AiConsultation.count") do
      post ai_consultations_url, params: { ai_consultation: { content: "テスト相談" } }
    end
    assert_redirected_to ai_consultations_url
  end
end
