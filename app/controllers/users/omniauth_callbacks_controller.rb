module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
      @user = User.from_omniauth(request.env["omniauth.auth"])

      sign_in_and_redirect @user, event: :authentication
    rescue StandardError => e
      Rails.logger.error "OAUTH ERROR: #{e.message}"
      Rails.logger.error e.backtrace.join("\n")
      redirect_to new_user_registration_url, alert: "OAuthエラー: #{e.message}"
    end

    def line
      user = User.from_omniauth(request.env["omniauth.auth"])

      if user.persisted?
        sign_in_and_redirect user, event: :authentication
        set_flash_message(:notice, :success, kind: "LINE") if is_navigational_format?
      else
        session["devise.line_data"] = request.env["omniauth.auth"].except(:extra)
        redirect_to new_user_registration_url, alert: "LINEアカウントでの認証に失敗しました。"
      end
    end
  end
end
