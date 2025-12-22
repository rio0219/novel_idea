require "rails_helper"

RSpec.describe "Works", type: :request do
  include Devise::Test::IntegrationHelpers

  let!(:user)  { create(:user) }
  let!(:genre) { create(:genre) }

  let(:valid_attrs)   { { work: { title: "作品", theme: "冒険", synopsis: "あらすじ", genre_id: genre.id } } }
  let(:invalid_attrs) { { work: { title: "", genre_id: nil } } }

  before do
    sign_in user
    @headers = { "ACCEPT" => "text/html" }
  end

  describe "GET #index" do
    it "returns ok" do
      get works_path, headers: @headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET #new" do
    it "returns ok" do
      get new_work_path, headers: @headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST #create" do
    it "creates work with valid attrs" do
      expect {
        post works_path, params: valid_attrs, headers: @headers
      }.to change(Work, :count).by(1)
    end

    it "does not create with invalid attrs" do
      expect {
        post works_path, params: invalid_attrs, headers: @headers
      }.not_to change(Work, :count)
    end
  end

  describe "PATCH #update" do
    let!(:work_rec) { create(:work, user: user, genre: genre, title: "old") }

    it "updates with valid" do
      patch work_path(work_rec), params: { work: { title: "new", genre_id: genre.id } }, headers: @headers
      expect(work_rec.reload.title).to eq("new")
    end

    it "does not update with invalid" do
      patch work_path(work_rec), params: { work: { title: "" } }, headers: @headers
      expect(work_rec.reload.title).to eq("old")
    end
  end

  describe "DELETE #destroy" do
    let!(:work_rec) { create(:work, user: user, genre: genre) }

    it "deletes" do
      expect {
        delete work_path(work_rec), headers: @headers
      }.to change(Work, :count).by(-1)
    end
  end
end
