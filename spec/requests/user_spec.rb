require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:user) { User.create!(email: "test@example.com", password: "password", name: "テストユーザー") }
  let!(:other_user) { User.create!(email: "other@example.com", password: "password") }

  before do
    login_as(user, scope: :user)
    @headers = { "ACCEPT" => "text/html" }
    allow_any_instance_of(ApplicationController)
      .to receive(:verify_authenticity_token).and_return(true)
  end

  after do
    Warden.test_reset!
  end

  describe "GET /users/:id" do
    it "自分のプロフィールにアクセスできる" do
      get user_path(user), headers: @headers
      expect(response).to have_http_status(:ok)
    end

    it "他人のプロフィールにもアクセスできる" do
      get user_path(other_user), headers: @headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /users/:id/edit" do
    it "自分の編集ページにアクセスできる" do
      get edit_user_path(user), headers: @headers
      expect(response).to have_http_status(:ok)
    end

    it "他人の編集ページにはリダイレクトされる" do
      get edit_user_path(other_user), headers: @headers
      expect(response).to redirect_to(other_user)
    end
  end
end
