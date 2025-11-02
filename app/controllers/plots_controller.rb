class PlotsController < ApplicationController
  before_action :set_work
  before_action :set_plot, only: [ :edit, :update, :destroy ]

  layout "work"

  def index
    @work = Work.find_by!(uuid: params[:work_id])
    @plots = @work.plots
  end

  def new
    @plot = @work.plots.build
  end

  def create
    @plot = @work.plots.build(plot_params)
    if @plot.save
      redirect_to work_plots_path(@work), notice: t("notices.created", resource: Plot.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @plot.update(plot_params)
      redirect_to work_plots_path(@work), notice: t("notices.updated", resource: Plot.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @plot.destroy
    redirect_to work_plots_path(@work), notice: t("notices.destroyed", resource: Plot.model_name.human)
  end

  private

  def set_work
    @work = Work.find_by!(uuid: params[:work_id])
  end

  def set_plot
    @plot = @work.plots.find(params[:id])
  end

  def plot_params
    params.require(:plot).permit(:chapter_title, :purpose, :event)
  end
end
