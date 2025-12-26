require "rails_helper"

RSpec.describe "Worldviews", type: :request do
  include Warden::Test::Helpers

  after { Warden.test_reset! }

  let!(:user)  { create(:user) }
  let!(:genre) { create(:genre) }
  let!(:work)  { create(:work, user: user, genre: genre) }

  before do
    login_as(user, scope: :user)
    @headers = { "ACCEPT" => "text/html" }
    allow_any_instance_of(ApplicationController).to receive(:verify_authenticity_token).and_return(true)
  end

  describe "GET new" do
    it {
      get new_work_worldview_path(work), headers: @headers
      expect(response).to have_http_status(:ok)
    }
  end

  describe "POST create" do
    it "creates valid" do
      expect {
        post work_worldview_path(work), params: { worldview: { country: "国", culture: "文化" } }, headers: @headers
      }.to change(Worldview, :count).by(1)
    end

    it "rejects invalid" do
      expect {
        post work_worldview_path(work), params: { worldview: { country: "", culture: "" } }, headers: @headers
      }.not_to change(Worldview, :count)
    end
  end

  describe "PATCH update" do
    let!(:worldview) { create(:worldview, work: work, country: "old", culture: "old") }

    it "updates" do
      patch work_worldview_path(work), params: { worldview: { country: "new", culture: "new" } }, headers: @headers
      expect(worldview.reload.country).to eq("new")
    end
  end

  describe "DELETE destroy" do
    let!(:worldview) { create(:worldview, work: work) }

    it "deletes" do
      expect {
        delete work_worldview_path(work), headers: @headers
      }.to change(Worldview, :count).by(-1)
    end
  end
end
