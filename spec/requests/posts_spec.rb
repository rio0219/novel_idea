require "rails_helper"

RSpec.describe "Posts", type: :request do
  include Warden::Test::Helpers

  after { Warden.test_reset! }

  let!(:user)  { create(:user) }
  let!(:genre) { create(:genre) }

  let(:valid_params)   { { post: { content: "本文です", genre_id: genre.id } } }
  let(:invalid_params) { { post: { content: "", genre_id: "" } } }

  before do
    login_as(user, scope: :user)
    @headers = { "ACCEPT" => "text/html" }
    allow_any_instance_of(ApplicationController).to receive(:verify_authenticity_token).and_return(true)
  end

  describe "GET #index" do
    it "returns 200" do
      get posts_path, headers: @headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET #new" do
    it "returns 200" do
      get new_post_path, headers: @headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST #create" do
    context "valid" do
      it "creates a Post" do
        expect {
          post posts_path, params: valid_params, headers: @headers
        }.to change(Post, :count).by(1)
      end
    end

    context "invalid" do
      it "does not create" do
        expect {
          post posts_path, params: invalid_params, headers: @headers
        }.not_to change(Post, :count)
      end
    end
  end

  describe "GET #edit" do
    let!(:post_record) { create(:post, user: user, genre: genre) }

    it "returns 200" do
      get edit_post_path(post_record), headers: @headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PATCH #update" do
    let!(:post_record) { create(:post, user: user, genre: genre, content: "before") }

    context "valid" do
      it "updates" do
        patch post_path(post_record), params: { post: { content: "after", genre_id: genre.id } }, headers: @headers
        expect(post_record.reload.content).to eq("after")
      end
    end

    context "invalid" do
      it "does not update" do
        patch post_path(post_record), params: { post: { content: "" } }, headers: @headers
        expect(post_record.reload.content).to eq("before")
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:post_record) { create(:post, user: user, genre: genre) }

    it "deletes" do
      expect {
        delete post_path(post_record), headers: @headers
      }.to change(Post, :count).by(-1)
    end
  end

  describe "search & autocomplete (collection actions)" do
    before { create_list(:post, 3, user: user, genre: genre, content: "search-target") }

    it "search returns 200" do
      get search_posts_path, params: { q: "search-target" }, headers: @headers
      expect(response).to have_http_status(:ok)
    end

    it "autocomplete returns 200" do
      get autocomplete_posts_path, params: { term: "sea" }, headers: @headers
      expect(response).to have_http_status(:ok)
    end
  end
end
