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
end
