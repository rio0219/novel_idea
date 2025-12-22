require "rails_helper"

RSpec.describe "Comments", type: :request do
  include Devise::Test::IntegrationHelpers

  let!(:user) { create(:user) }
  let!(:genre) { create(:genre) }
  let!(:post_record) { create(:post, user: user, genre: genre) }

  before do
    sign_in user
    @headers = {
      "ACCEPT" => "text/vnd.turbo-stream.html",
      "X-Requested-With" => "XMLHttpRequest"
    }
  end

  describe "POST /posts/:post_id/comments" do
    it "creates comment with valid params" do
      expect do
        post post_comments_path(post_record),
             params: { comment: { content: "nice!" } },
             headers: @headers

        puts "STATUS = #{response.status}"
        puts "BODY = #{response.body}"
      end.to change(Comment, :count).by(1)

      expect(response).to have_http_status(:ok)
      expect(response.media_type).to eq "text/vnd.turbo-stream.html"
    end
  end

  describe "DELETE /posts/:post_id/comments/:id" do
    let!(:comment) { create(:comment, post: post_record, user: user) }

    it "deletes comment" do
      expect do
        delete post_comment_path(post_record, comment), headers: @headers
      end.to change(Comment, :count).by(-1)
    end
  end
end
