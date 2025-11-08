module Users
  class RegistrationsController < Devise::RegistrationsController
    def create
      super do |user|
        sign_in(user) if user.persisted? # 登録完了後に自動ログイン
      end
    end
  end
end
