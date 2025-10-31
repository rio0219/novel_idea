class CommentsController < ApplicationController
  before_action :set_post

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      # Turbo Streamsで非同期更新する場合
      respond_to do |format|
        format.turbo_stream do
          @comments = @post.comments.includes(:user).order(created_at: :desc)
          render turbo_stream: turbo_stream.replace(
            "comments",
            partial: "comments/comment",
            collection: @comments
          )
        end
        format.html { redirect_to @post, notice: "コメントを投稿しました" }
      end
    else
      @comments = @post.comments.includes(:user).order(created_at: :desc)
      render "posts/show", status: :unprocessable_entity
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
