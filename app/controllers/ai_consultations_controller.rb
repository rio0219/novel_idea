class AiConsultationsController < ApplicationController
  before_action :authenticate_user!


  def index
    @consultations = current_user.ai_consultations.order(created_at: :desc)
    @ai_consultation= AiConsultation.new
    if params[:return_to].present?
      session[:return_to] = params[:return_to]
    end
    @return_to = session[:return_to]
  end

  def create
    @consultation = current_user.ai_consultations.build(ai_consultation_params)

    if @consultation.save
      response_text = call_ai_api(@consultation.content)
      @consultation.update(response: response_text)
      redirect_to(params[:return_to].presence || ai_consultations_path, notice: "相談を送信しました。")
    else
      render :index
    end
  end


  private

  def ai_consultation_params
    params.require(:ai_consultation).permit(:content)
  end

  def call_ai_api(content)
    client = OpenAI::Client.new

    response = client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: [
          { role: "system", content: "あなたは小説やアイデアの相談に答えるアシスタントです。" },
          { role: "user", content: content }
        ],
        temperature: 0.7 # 出力のランダム性（0〜2）を調整
      }
    )

    # APIレスポンスから本文を抜き出し
    response.dig("choices", 0, "message", "content") || "AIからの返答を取得できませんでした。"
  rescue => e
    Rails.logger.error("AI API 呼び出しエラー: #{e.message}")
    "AI呼び出し中にエラーが発生しました。"
  end
end
