require "rails_helper"

RSpec.describe "Contacts", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/contacts/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "creates a contact and redirects" do
      post contacts_path, params: { contact: { name: "テスト", email: "test@example.com", message: "hello" } }
      expect(response).to have_http_status(:found) # リダイレクト
    end
  end
end
