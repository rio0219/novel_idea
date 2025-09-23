class WorldviewsController < ApplicationController
  before_action :set_work
  before_action :set_worldview, only: [ :edit, :update, :destroy ]

  def new
    @worldview = @work.build_worldview
  end

  def create
    Rails.logger.debug "=== params start ==="
    Rails.logger.debug params.inspect
    Rails.logger.debug "=== params end ==="
    @work = Work.find(params[:work_id])
    @worldview = @work.build_worldview(worldview_params)
    if @worldview.save
      redirect_to works_path, notice: t("notices.created", resource: Worldview.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end


  def update
    if @worldview.update(worldview_params)
      redirect_to works_path, notice: t("notices.updated", resource: Worldview.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @worldview.destroy
    redirect_to works_path, notice: t("notices.destroyed", model: Worldview.model_name.human)
  end

  def show
    @work = Work.find(params[:id])
  end

  private

  def set_work
    @work = Work.find(params[:work_id])
  end

  def set_worldview
    @worldview = @work.worldview
  end

  def worldview_params
    params.require(:worldview).permit(:country, :culture, :technology, :faction)
  end
end
