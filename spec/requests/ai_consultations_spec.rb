require 'rails_helper'

RSpec.describe "AiConsultations", type: :request do
  let!(:user) { User.create!(email: "test@example.com", password: "password") }

  let(:valid_attributes) do
    { content: "これは有効な相談内容です。" }
  end

  let(:invalid_attributes) do
    { content: "" }
  end

  before do
    # ログイン
    login_as(user, scope: :user)
    @headers = { "ACCEPT" => "text/html" }

    # CSRF を回避
    allow_any_instance_of(ApplicationController)
      .to receive(:verify_authenticity_token).and_return(true)
  end

  after do
    Warden.test_reset!
  end

  describe "GET /ai_consultations" do
    it "レスポンスが成功すること" do
      get ai_consultations_path, headers: @headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /ai_consultations" do
    context "有効なパラメータの場合" do
      it "AiConsultationが作成されること" do
        expect {
          post ai_consultations_path, params: { ai_consultation: valid_attributes }, headers: @headers
        }.to change(AiConsultation, :count).by(1)
      end
    end

    context "無効なパラメータの場合" do
      it "AiConsultationが作成されないこと" do
        expect {
          post ai_consultations_path, params: { ai_consultation: invalid_attributes }, headers: @headers
        }.not_to change(AiConsultation, :count)
      end
    end
  end
end
