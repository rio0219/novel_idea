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
end
