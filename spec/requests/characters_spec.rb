require "rails_helper"

RSpec.describe "Characters", type: :request do
  include Warden::Test::Helpers

  after { Warden.test_reset! }

  let!(:user)  { create(:user) }
  let!(:genre) { create(:genre) }
  let!(:work)  { create(:work, user: user, genre: genre) }
  let!(:character) { create(:character, work: work) }

  before do
    login_as(user, scope: :user)
    @headers = { "ACCEPT" => "text/html" }
    allow_any_instance_of(ApplicationController).to receive(:verify_authenticity_token).and_return(true)
  end

  describe "GET index" do
    it "ok" do
      get work_characters_path(work), headers: @headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST create" do
    it "creates with valid" do
      expect {
        post work_characters_path(work), params: { character: { name: "New", background: "bg" } }, headers: @headers
      }.to change(Character, :count).by(1)
    end

    it "rejects invalid" do
      expect {
        post work_characters_path(work), params: { character: { name: "" } }, headers: @headers
      }.not_to change(Character, :count)
    end
  end

  describe "PATCH update" do
    it "updates" do
      patch work_character_path(work, character), params: { character: { name: "Updated" } }, headers: @headers
      expect(character.reload.name).to eq("Updated")
    end
  end

  describe "DELETE destroy" do
    it "deletes" do
      expect {
        delete work_character_path(work, character), headers: @headers
      }.to change(Character, :count).by(-1)
    end
  end
end
