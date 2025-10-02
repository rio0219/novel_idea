require 'rails_helper'

RSpec.describe Work, type: :model do
  let(:user) { User.create!(email: "test@example.com", password: "password") }
  let(:genre) { Genre.create!(name: "ファンタジー") }

  describe 'バリデーション' do
    it 'title があれば有効' do
      work = Work.new(title: 'サンプルタイトル', user: user, genre: genre)
      expect(work).to be_valid
    end

    it 'title が空だと無効' do
      work = Work.new(title: '', user: user, genre: genre)
      expect(work).not_to be_valid
    end

    it 'title が100文字以内なら有効' do
      work = Work.new(title: 'a' * 100, user: user, genre: genre)
      expect(work).to be_valid
    end

    it 'title が101文字以上だと無効' do
      work = Work.new(title: 'a' * 101, user: user, genre: genre)
      expect(work).not_to be_valid
    end

    it 'theme が50文字以内なら有効' do
      work = Work.new(title: 'タイトル', theme: 'a' * 50, user: user, genre: genre)
      expect(work).to be_valid
    end

    it 'theme が51文字以上だと無効' do
      work = Work.new(title: 'タイトル', theme: 'a' * 51, user: user, genre: genre)
      expect(work).not_to be_valid
    end

    it 'synopsis が1000文字以内なら有効' do
      work = Work.new(title: 'タイトル', synopsis: 'a' * 1000, user: user, genre: genre)
      expect(work).to be_valid
    end

    it 'synopsis が1001文字以上だと無効' do
      work = Work.new(title: 'タイトル', synopsis: 'a' * 1001, user: user, genre: genre)
      expect(work).not_to be_valid
    end
  end
end
