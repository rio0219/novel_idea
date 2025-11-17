require "rails_helper"

RSpec.describe "Likes", type: :request do
  include Devise::Test::IntegrationHelpers

  let!(:user) { create(:user) }
  let!(:genre) { create(:genre) }
  let!(:post_record) { create(:post, user: user, genre: genre) }

  before do
    sign_in user
    @headers = { "ACCEPT" => "text/html" }
  end

  describe "POST /posts/:post_id/likes" do
    it "creates a like" do
      expect do
        post post_likes_path(post_record), headers: @headers
      end.to change(Like, :count).by(1)
    end

    it "does not duplicate like for same user" do
      create(:like, user: user, post: post_record)
      expect do
        post post_likes_path(post_record), headers: @headers
      end.not_to change(Like, :count)
    end
  end

  describe "DELETE /posts/:post_id/likes/:id" do
    let!(:like) { create(:like, user: user, post: post_record) }

    it "destroys the like" do
      expect do
        delete post_like_path(post_record, like), headers: @headers
      end.to change(Like, :count).by(-1)
    end
  end
end
