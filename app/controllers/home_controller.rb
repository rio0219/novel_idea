class HomeController < ApplicationController
  # 全部でログイン必須にしている場合は ↓ を使う
  # skip_before_action :authenticate_user!, only: [:index]

  def index
    if user_signed_in?
      @works = current_user.works
    end
  end
end
