require 'rails_helper'

RSpec.describe Worldview, type: :model do
  let(:user) { User.create!(email: "test@example.com", password: "password") }
  let(:genre) { Genre.create!(name: "ファンタジー") }
  let(:work) { Work.create!(title: "テスト作品", user: user, genre: genre) }

  describe 'バリデーション' do
    it 'country と culture があれば有効' do
      worldview = Worldview.new(country: "日本", culture: "和風", work: work)
      expect(worldview).to be_valid
    end

    it 'country が空だと無効' do
      worldview = Worldview.new(country: "", culture: "和風", work: work)
      expect(worldview).not_to be_valid
    end

    it 'culture が空だと無効' do
      worldview = Worldview.new(country: "日本", culture: "", work: work)
      expect(worldview).not_to be_valid
    end
  end

  describe "アソシエーション" do
    it { should belong_to(:work) }
  end
end
