require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create!(email: "test@example.com", password: "password") }
  let(:genre) { Genre.create!(name: "テストジャンル") }

  describe 'バリデーション' do
    it 'content があれば有効' do
      post = Post.new(content: "これはテスト投稿です", user: user, genre: genre)
      expect(post).to be_valid
    end

    it 'content が空だと無効' do
      post = Post.new(content: "", user: user, genre: genre)
      expect(post).not_to be_valid
    end

    it 'content が1000文字以内なら有効' do
      post = Post.new(content: "a" * 1000, user: user, genre: genre)
      expect(post).to be_valid
    end

    it 'content が1001文字以上だと無効' do
      post = Post.new(content: "a" * 1001, user: user, genre: genre)
      expect(post).not_to be_valid
    end
  end

  describe "アソシエーション" do
    it { should belong_to(:user) }
    it { should belong_to(:genre) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
  end

  describe "#liked_by?" do
    let(:post_record) { Post.create!(content: "test", user: user, genre: genre) }

    it "いいね済みなら true を返す" do
      Like.create!(user: user, post: post_record)
      expect(post_record.liked_by?(user)).to be true
    end

    it "いいねしていなければ false を返す" do
      expect(post_record.liked_by?(user)).to be false
    end
  end

  describe "#to_param" do
    it "uuid を返す" do
      post = Post.create!(content: "test", user: user, genre: genre)
      expect(post.to_param).to eq(post.uuid)
    end
  end
end
