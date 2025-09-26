class HomeController < ApplicationController
  def index
    @works = current_user&.works || Work.none
  end
end
