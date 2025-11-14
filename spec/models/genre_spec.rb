require "rails_helper"

RSpec.describe Genre, type: :model do
  describe "アソシエーション" do
    it { should have_many(:works) }
    it { should have_many(:posts) }
  end
end
