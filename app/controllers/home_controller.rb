class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @works = current_user.works.includes(:genre)
  end
end
