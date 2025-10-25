RSpec.describe "Worldviews", type: :request do
  let!(:user)  { User.create!(email: "test@example.com", password: "password") }
  let!(:genre) { Genre.create!(name: "ファンタジー") }
  let!(:work)  { Work.create!(title: "テスト作品", theme: "冒険", synopsis: "あらすじです", genre_id: genre.id, user: user) }

  before do
    login_as(user, scope: :user)
    @headers = { "ACCEPT" => "text/html" }
    allow_any_instance_of(ApplicationController)
      .to receive(:verify_authenticity_token).and_return(true)
  end

  describe "GET /works/:work_id/worldview/new" do
    it "レスポンスが成功すること" do
      get new_work_worldview_path(work), headers: @headers
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /works/:work_id/worldview" do
    context "有効なパラメータの場合" do
      it "Worldviewが作成されること" do
        expect {
          post work_worldview_path(work),
               params: { worldview: { country: "Fantasy World", culture: "Magic and myths" } }, headers: @headers
        }.to change(Worldview, :count).by(1)
      end
    end

    context "無効なパラメータの場合" do
      it "Worldviewが作成されないこと" do
        expect {
          post work_worldview_path(work), params: { worldview: { country: "", culture: "" } }, headers: @headers
        }.not_to change(Worldview, :count)
      end
    end
  end

  describe "GET /works/:work_id/worldview/edit" do
    let!(:worldview) { Worldview.create!(country: "Old country", culture: "Old culture", work: work) }

    it "レスポンスが成功すること" do
      get edit_work_worldview_path(work), headers: @headers
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /works/:work_id/worldview" do
    let!(:worldview) { Worldview.create!(country: "Old country", culture: "Old culture", work: work) }

    context "有効なパラメータの場合" do
      it "Worldviewが更新されること" do
        patch work_worldview_path(work), params: { worldview: { country: "New country", culture: "New culture" } },
                                         headers: @headers
        expect(worldview.reload.country).to eq("New country")
        expect(worldview.reload.culture).to eq("New culture")
      end
    end

    context "無効なパラメータの場合" do
      it "Worldviewが更新されないこと" do
        patch work_worldview_path(work), params: { worldview: { country: "", culture: "" } }, headers: @headers
        expect(worldview.reload.country).to eq("Old country")
        expect(worldview.reload.culture).to eq("Old culture")
      end
    end
  end

  describe "DELETE /works/:work_id/worldview" do
    let!(:worldview) { Worldview.create!(country: "To Be Deleted", culture: "Temporary culture", work: work) }

    it "Worldviewが削除されること" do
      expect {
        delete work_worldview_path(work), headers: @headers
      }.to change(Worldview, :count).by(-1)
    end
  end
end
