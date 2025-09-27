require "test_helper"

class AiConsultationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ai_consultations_index_url
    assert_response :success
  end

  test "should get create" do
    get ai_consultations_create_url
    assert_response :success
  end
end
