class LikesController < ApplicationController
  before_action :set_post

  def create
    @post.likes.create(user: current_user)
    @post.reload
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "like-button-#{@post.id}",
          partial: "likes/like",
          locals: { post: @post }
        )
      end
      format.html { redirect_to @post }
    end
  end

  def destroy
    like = @post.likes.find_by(user: current_user)
    like&.destroy
    @post.reload
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "like-button-#{@post.id}",
          partial: "likes/like",
          locals: { post: @post }
        )
      end
      format.html { redirect_to @post }
    end
  end

  private

  def set_post
    @post = Post.find_by!(uuid: params[:post_id])
  end
end
