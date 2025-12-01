module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :skip_turbo
    def create
      super do |user|
        sign_in(user) if user.persisted? # 登録完了後に自動ログイン
      end
    end


    private

    def skip_turbo
      request.headers["Turbo-Frame"] = nil
    end
  end
end
