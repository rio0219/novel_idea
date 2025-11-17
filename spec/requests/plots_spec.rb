require "rails_helper"

RSpec.describe "Plots", type: :request do
  include Warden::Test::Helpers

  after { Warden.test_reset! }

  let!(:user)  { create(:user) }
  let!(:genre) { create(:genre) }
  let!(:work)  { create(:work, user: user, genre: genre) }
  let!(:plot)  { create(:plot, work: work) }

  before do
    login_as(user, scope: :user)
    @headers = { "ACCEPT" => "text/html" }
    allow_any_instance_of(ApplicationController).to receive(:verify_authenticity_token).and_return(true)
  end

  describe "GET index/new" do
    it {
      get work_plots_path(work), headers: @headers
      expect(response).to have_http_status(:ok)
    }
    it {
      get new_work_plot_path(work), headers: @headers
      expect(response).to have_http_status(:ok)
    }
  end

  describe "POST create" do
    it "creates valid" do
      expect {
        post work_plots_path(work), params: { plot: { chapter_title: "新章", purpose: "目的" } }, headers: @headers
      }.to change(Plot, :count).by(1)
    end

    it "rejects invalid" do
      expect {
        post work_plots_path(work), params: { plot: { chapter_title: "" } }, headers: @headers
      }.not_to change(Plot, :count)
    end
  end

  describe "PATCH update" do
    it "updates" do
      patch work_plot_path(work, plot), params: { plot: { chapter_title: "更新" } }, headers: @headers
      expect(plot.reload.chapter_title).to eq("更新")
    end
  end

  describe "DELETE destroy" do
    it "deletes" do
      expect {
        delete work_plot_path(work, plot), headers: @headers
      }.to change(Plot, :count).by(-1)
    end
  end
end
