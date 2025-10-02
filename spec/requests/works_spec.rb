require 'rails_helper'

RSpec.describe "Works", type: :request do
  let!(:user)  { User.create!(email: "test@example.com", password: "password") }
  let!(:genre) { Genre.create!(name: "ファンタジー") }

  let(:valid_attributes) do
    { title: "テスト作品", theme: "冒険", synopsis: "あらすじです", genre_id: genre.id }
  end

  let(:invalid_attributes) do
    { title: "", genre_id: nil } # 無効値は nil にして確実にバリデーションに引っかかるように
  end

  let!(:work_record) { Work.create!(valid_attributes.merge(user: user)) }

  before do
    # Warden でログイン
    login_as(user, scope: :user)
    @headers = { "ACCEPT" => "text/html" }

    # CSRF 回避（必要なら）
    allow_any_instance_of(ApplicationController)
      .to receive(:verify_authenticity_token).and_return(true)
  end

  after do
    Warden.test_reset!
  end

  describe "GET /index" do
    it "レスポンスが成功すること" do
      get works_path, headers: @headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /new" do
    it "レスポンスが成功すること" do
      get new_work_path, headers: @headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /edit" do
    it "レスポンスが成功すること" do
      get edit_work_path(work_record), headers: @headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /create" do
    context "有効なパラメータの場合" do
      it "Workが作成されること" do
        expect {
          post works_path, params: { work: valid_attributes }, headers: @headers
        }.to change(Work, :count).by(1)
      end
    end

    context "無効なパラメータの場合" do
      it "Workが作成されないこと" do
        expect {
          post works_path, params: { work: invalid_attributes }, headers: @headers
        }.not_to change(Work, :count)
      end
    end
  end

  describe "PATCH /update" do
    context "有効なパラメータの場合" do
      it "Workが更新されること" do
        patch work_path(work_record), params: { work: { title: "更新後タイトル", genre_id: genre.id } }, headers: @headers
        expect(work_record.reload.title).to eq("更新後タイトル")
      end
    end

    context "無効なパラメータの場合" do
      it "Workが更新されないこと" do
        original_title = work_record.title
        patch work_path(work_record), params: { work: invalid_attributes }, headers: @headers
        expect(work_record.reload.title).to eq(original_title)
      end
    end
  end

  describe "DELETE /destroy" do
    it "Workが削除されること" do
      expect {
        delete work_path(work_record), headers: @headers
      }.to change(Work, :count).by(-1)
    end
  end
end
