require 'rails_helper'

RSpec.describe AiConsultation, type: :model do
  let(:user) { User.create!(email: "test@example.com", password: "password") }

  describe 'バリデーション' do
    it 'content があれば有効' do
      consultation = AiConsultation.new(content: "これは相談内容です", user: user)
      expect(consultation).to be_valid
    end

    it 'content が空だと無効' do
      consultation = AiConsultation.new(content: "", user: user)
      expect(consultation).not_to be_valid
    end
  end

  describe "アソシエーション" do
    it { should belong_to(:user) }
  end
end
