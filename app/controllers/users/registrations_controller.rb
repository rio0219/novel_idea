module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :disable_turbo, only: [:new, :create]

    def create
      super do |user|
        sign_in(user) if user.persisted?
      end
    end

    private

    def disable_turbo
      @disable_turbo = true
    end
  end
end
