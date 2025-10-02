require 'rails_helper'

RSpec.describe Plot, type: :model do
  let(:user) { User.create!(email: "test@example.com", password: "password") }
  let(:genre) { Genre.create!(name: "ファンタジー") }
  let(:work) { Work.create!(title: "テスト作品", user: user, genre: genre) }

  describe 'バリデーション' do
    it 'chapter_title があれば有効' do
      plot = Plot.new(chapter_title: "第1章", work: work)
      expect(plot).to be_valid
    end

    it 'chapter_title が空だと無効' do
      plot = Plot.new(chapter_title: "", work: work)
      expect(plot).not_to be_valid
    end
  end
end
