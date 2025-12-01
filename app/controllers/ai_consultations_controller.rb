class AiConsultationsController < ApplicationController
  before_action :authenticate_user!


  def index
    @consultations_all = current_user.ai_consultations.order(created_at: :desc, id: :desc)
  
    @latest_consultation = @consultations_all.first     # 最新1件
    @consultations      = @consultations_all.offset(1)  # 2件目以降
  
    @ai_consultation = AiConsultation.new
  
    if params[:return_to].present?
      session[:return_to] = params[:return_to]
    end
    @return_to = session[:return_to]
  end

  def create
    @ai_consultation = current_user.ai_consultations.build(ai_consultation_params)
  
    if @ai_consultation.save
      response_text = call_ai_api(@ai_consultation.content)
      @ai_consultation.update(response: response_text)
  
      respond_to do |format|
        format.json do
          html = render_to_string(
            partial: "ai_consultations/ai_consultation",
            locals: { consultation: @ai_consultation },
            formats: [:html]
          )
          render json: { html: html }, status: :ok
        end        
  
        format.html do
          redirect_to ai_consultations_path, notice: "相談を送信しました。"
        end
      end
  
    else
      respond_to do |format|
        format.json do
          render json: { error: "保存に失敗しました" }, status: :unprocessable_entity
        end
        format.html do
          @consultations = current_user.ai_consultations.order(created_at: :desc, id: :desc)
          render :index, status: :unprocessable_entity
        end
      end
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
