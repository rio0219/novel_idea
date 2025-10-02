require 'rails_helper'

RSpec.describe "Characters", type: :request do
  let!(:user)  { User.create!(email: "test@example.com", password: "password") }
  let!(:genre) { Genre.create!(name: "ファンタジー") }
  let!(:work)  { Work.create!(title: "テスト作品", theme: "冒険", synopsis: "あらすじです",  genre_id: genre.id, user: user) }
  let!(:character) { Character.create!(name: "Old Hero", background: "古いキャラ", work_id: work.id) }

  let(:valid_attributes)   { { name: "Hero", background: "勇敢なキャラ", work_id: work.id } }
  let(:invalid_attributes) { { name: "", background: "", work_id: nil } }
  let(:update_attributes)  { { name: "Updated Hero", background: "更新されたキャラ", work_id: work.id } }

  before do
    login_as(user, scope: :user)
    @headers = { "ACCEPT" => "text/html" }

    allow_any_instance_of(ApplicationController)
      .to receive(:verify_authenticity_token).and_return(true)
  end

  describe "GET /characters" do
    it "レスポンスが成功すること" do
      get work_characters_path(work), headers: @headers
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /characters" do
    context "有効なパラメータの場合" do
      it "Characterが作成されること" do
        expect {
          post work_characters_path(work), params: { character: valid_attributes }, headers: @headers
        }.to change(Character, :count).by(1)
      end
    end

    context "無効なパラメータの場合" do
      it "Characterが作成されないこと" do
        expect {
          post work_characters_path(work), params: { character: invalid_attributes }, headers: @headers
        }.not_to change(Character, :count)
      end
    end
  end

  describe "PATCH /characters/:id" do
    context "有効なパラメータの場合" do
      it "Characterが更新されること" do
        patch work_character_path(work, character), params: { character: update_attributes }, headers: @headers
        character.reload
        expect(character.name).to eq("Updated Hero")
        expect(response).to redirect_to(work_characters_path(work)) # 更新後のリダイレクト先に合わせて修正
      end
    end

    context "無効なパラメータの場合" do
      it "Characterが更新されないこと" do
        patch work_character_path(work, character), params: { character: invalid_attributes }, headers: @headers
        character.reload
        expect(character.name).to eq("Old Hero")
      end
    end
  end

  describe "DELETE /characters/:id" do
    it "Characterが削除されること" do
      expect {
        delete work_character_path(work, character), headers: @headers
      }.to change(Character, :count).by(-1)
      expect(response).to redirect_to(work_characters_path(work)) # 削除後のリダイレクト先に合わせて修正
    end
  end
end
