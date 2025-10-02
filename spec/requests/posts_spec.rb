require "rails_helper"

RSpec.describe "Posts", type: :request do
  let!(:user)  { User.create!(email: "test@example.com", password: "password") }
  let!(:genre) { Genre.create!(name: "ファンタジー") }
  let(:post_record) { Post.create!(content: "本文です", user: user, genre_id: genre.id) }

  before do
    login_as(user, scope: :user)
    @headers = { "ACCEPT" => "text/html" }

    allow_any_instance_of(ApplicationController)
      .to receive(:verify_authenticity_token).and_return(true)
  end

  describe "GET /posts" do
    it "レスポンスが成功すること" do
      get posts_path, headers: @headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /posts/new" do
    it "レスポンスが成功すること" do
      get new_post_path, headers: @headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /posts" do
    context "有効なパラメータの場合" do
      it "Postが作成されること" do
        expect {
          post posts_path, params: { post: { content: "本文", genre_id: genre.id  } }, headers: @headers
        }.to change(Post, :count).by(1)
      end
    end

    context "無効なパラメータの場合" do
      it "Postが作成されないこと" do
        expect {
          post posts_path, params: { post: { content: "", genre_id: "" } }, headers: @headers
        }.not_to change(Post, :count)
      end
    end
  end

  describe "GET /posts/:id/edit" do
    it "レスポンスが成功すること" do
      get edit_post_path(post_record), headers: @headers
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /posts/:id" do
    context "有効なパラメータの場合" do
      it "Postが更新されること" do
        patch post_path(post_record), params: { post: { content: "更新後本文", genre_id: genre.id } }, headers: @headers
        expect(post_record.reload.content).to eq("更新後本文")
      end
    end

    context "無効なパラメータの場合" do
      it "Postが更新されないこと" do
        patch post_path(post_record), params: {  post: { content: nil, genre_id: nil } }, headers: @headers
        expect(post_record.reload.content).to eq("本文です")
      end
    end
  end

  describe "DELETE /posts/:id" do
    it "Postが削除されること" do
      post_record # 事前作成
      expect {
        delete post_path(post_record), headers: @headers
      }.to change(Post, :count).by(-1)
    end
  end
end
