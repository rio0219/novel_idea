require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#display_name" do
    it "name がある場合はそのまま返す" do
      user = User.new(name: "Alice")
      expect(user.display_name).to eq("Alice")
    end

    it "name がない場合は '名無しさん' を返す" do
      user = User.new(name: nil)
      expect(user.display_name).to eq("名無しさん")

      user = User.new(name: "")
      expect(user.display_name).to eq("名無しさん")
    end
  end

  describe "アソシエーション" do
    it { should have_many(:works).dependent(:destroy) }
    it { should have_many(:posts).dependent(:destroy) }
    it { should have_many(:ai_consultations).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
  end

  describe "#to_param" do
    it "uuid を返す" do
      user = User.create!(email: "test2@example.com", password: "password")
      expect(user.to_param).to eq(user.uuid)
    end
  end
end
