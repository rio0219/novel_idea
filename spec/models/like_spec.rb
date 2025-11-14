require "rails_helper"

RSpec.describe Like, type: :model do
  describe "バリデーション" do
    let(:user) { create(:user) }
    let(:post) { create(:post) }

    it "user_id と post_id の組み合わせはユニークである" do
      Like.create!(user: user, post: post)
      duplicate_like = Like.new(user: user, post: post)

      expect(duplicate_like).to be_invalid
      expect(duplicate_like.errors[:user_id]).to include("はすでに存在します")
    end
  end
end
