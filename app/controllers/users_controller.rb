class UsersController < ApplicationController
  layout "posts"
  before_action :set_user, only: [ :show, :edit, :update ]

  def show
    @user = User.find_by!(uuid: params[:id])
    @posts = @user.posts
    @liked_posts = @user.liked_posts.includes(:user, :genre, :tags)
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
    @user = User.find_by!(uuid: params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :bio, :image)
  end
end
