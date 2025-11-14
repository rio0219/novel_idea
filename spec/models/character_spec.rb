require 'rails_helper'

RSpec.describe Character, type: :model do
  let(:user) { User.create!(email: "test@example.com", password: "password") }
  let(:genre) { Genre.create!(name: "ファンタジー") }
  let(:work) { Work.create!(title: "テスト作品", user: user, genre: genre) }

  describe "バリデーション" do
    it "name があれば有効" do
      character = work.characters.build(name: "テストキャラ")
      expect(character).to be_valid
    end

    it "name が空だと無効" do
      character = work.characters.build(name: nil)
      expect(character).to_not be_valid
      expect(character.errors[:name]).to include("を入力してください")
    end
  end

  describe "アソシエーション" do
    it { should belong_to(:work) }
  end
end
