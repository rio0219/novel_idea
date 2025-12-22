require "rails_helper"

RSpec.describe "Users", type: :request do
  include Warden::Test::Helpers

  after { Warden.test_reset! }

  let!(:user) { create(:user, name: "テストユーザー") }
  let!(:other) { create(:user) }

  before do
    login_as(user, scope: :user)
    @headers = { "ACCEPT" => "text/html" }
    allow_any_instance_of(ApplicationController).to receive(:verify_authenticity_token).and_return(true)
  end

  describe "GET show" do
    it "can view own profile" do
      get user_path(user), headers: @headers
      expect(response).to have_http_status(:ok)
    end

    it "can view other's profile" do
      get user_path(other), headers: @headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET edit" do
    it "access own edit" do
      get edit_user_path(user), headers: @headers
      expect(response).to have_http_status(:ok)
    end

    it "cannot edit other" do
      get edit_user_path(other), headers: @headers
      # your app may redirect elsewhere — adjust expectation if needed
      expect(response).to_not have_http_status(:ok)
    end
  end

  describe "PATCH update" do
    it "updates own profile" do
      patch user_path(user), params: { user: { name: "NewName" } }, headers: @headers
      expect(user.reload.name).to eq("NewName")
    end
  end
end
