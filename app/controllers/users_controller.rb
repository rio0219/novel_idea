class UsersController < ApplicationController
  layout "posts"
  before_action :set_user, only: [ :show, :edit, :update ]

  def show
    @posts = @user.posts
  end

  def edit
    redirect_to @user unless @user == current_user
  end

  def update
    if @user == current_user && @user.update(user_params)
      redirect_to @user, notice: t("notices.updated", resource: User.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :bio)
  end
end
