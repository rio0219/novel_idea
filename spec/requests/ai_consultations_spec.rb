require "rails_helper"

RSpec.describe "AiConsultations", type: :request do
  include Warden::Test::Helpers

  after { Warden.test_reset! }

  let!(:user) { create(:user) }

  before do
    login_as(user, scope: :user)
    @headers = { "ACCEPT" => "text/html" }
    allow_any_instance_of(ApplicationController).to receive(:verify_authenticity_token).and_return(true)
  end

  describe "GET index" do
    it "ok" do
      get ai_consultations_path, headers: @headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST create" do
    it "creates with valid" do
      expect {
        post ai_consultations_path, params: { ai_consultation: { content: "相談" } }, headers: @headers
      }.to change(AiConsultation, :count).by(1)
    end

    it "rejects invalid" do
      expect {
        post ai_consultations_path, params: { ai_consultation: { content: "" } }, headers: @headers
      }.not_to change(AiConsultation, :count)
    end
  end
end
