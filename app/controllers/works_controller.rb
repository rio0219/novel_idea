class WorksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_work, only: [ :edit, :update ]

  layout :select_layout

  def index
    @works = current_user.works
  end

  def new
    @work = current_user.works.build
    @genres = Genre.all
  end

  def create
    @work = current_user.works.build(work_params)
    if @work.save
      redirect_to edit_work_path(@work), notice: t("notices.created", resource: Work.model_name.human)
    else
      @genres = Genre.all
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @genres = Genre.all
  end

  def update
    if @work.update(work_params)
      redirect_to root_path, notice: t("notices.updated", resource: Work.model_name.human)
    else
      @genres = Genre.all
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @work = current_user.works.find(params[:id])
    @work.destroy
    redirect_to root_path, notice: t("notices.destroyed", resource: Work.model_name.human)
  end

  private

  def set_work
    @work = Work.find_by!(uuid: params[:id])
  end

  def work_params
    params.require(:work).permit(:title, :theme, :synopsis, :genre_id)
  end

  def select_layout
    if action_name == "index"
      "application"
    else
      "work"
    end
  end
end
