require "rails_helper"

RSpec.describe "Plots", type: :request do
  let!(:user)  { User.create!(email: "test@example.com", password: "password") }
  let!(:genre) { Genre.create!(name: "ファンタジー") }
  let!(:work)  { Work.create!(title: "テスト作品", theme: "冒険", synopsis: "あらすじです",  genre_id: genre.id, user: user) }
  let(:plot) { Plot.create!(chapter_title: "サンプルプロット", purpose: "目的", work_id: work.id) }

  before do
    # ログイン
    login_as(user, scope: :user)
    @headers = { "ACCEPT" => "text/html" }

    # CSRF を回避
    allow_any_instance_of(ApplicationController)
      .to receive(:verify_authenticity_token).and_return(true)
  end

  describe "GET /works/:work_id/plots" do
    it "レスポンスが成功すること" do
      get work_plots_path(work), headers: @headers
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /works/:work_id/plots/new" do
    it "レスポンスが成功すること" do
      get new_work_plot_path(work), headers: @headers
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /works/:work_id/plots" do
    context "有効なパラメータの場合" do
      it "Plotが作成されること" do
        expect {
          post work_plots_path(work), params: { plot: { chapter_title: "新規プロット", purpose: "目的" } }, headers: @headers
        }.to change(Plot, :count).by(1)
      end
    end

    context "無効なパラメータの場合" do
      it "Plotが作成されないこと" do
        expect {
          post work_plots_path(work), params: { plot: { chapter_title: "" } }, headers: @headers
        }.not_to change(Plot, :count)
      end
    end
  end

  describe "GET /works/:work_id/plots/:id/edit" do
    it "レスポンスが成功すること" do
      get edit_work_plot_path(work, plot), headers: @headers
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /works/:work_id/plots/:id" do
    context "有効なパラメータの場合" do
      it "Plotが更新されること" do
        patch work_plot_path(work, plot), params: { plot: { chapter_title: "更新後タイトル" } }, headers: @headers
        expect(plot.reload.chapter_title).to eq("更新後タイトル")
      end
    end

    context "無効なパラメータの場合" do
      it "Plotが更新されないこと" do
        patch work_plot_path(work, plot), params: { plot: { chapter_title: "" } }, headers: @headers
        expect(plot.reload.chapter_title).to eq("サンプルプロット")
      end
    end
  end

  describe "DELETE /works/:work_id/plots/:id" do
    it "Plotが削除されること" do
      plot # 事前作成
      expect {
        delete work_plot_path(work, plot), headers: @headers
      }.to change(Plot, :count).by(-1)
    end
  end
end
