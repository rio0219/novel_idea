class PostsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_post, only: [ :show, :edit, :update, :destroy ]

  # みんなのアイデア一覧
  def index
    @posts = Post.includes(:user, :genre).order(created_at: :desc)
  end

  # コメント一覧兼詳細
  def show
    @comments = @post.comments.includes(:user).order(created_at: :desc)
    @comment = Comment.new
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, notice: "投稿を作成しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    redirect_to posts_path, alert: "権限がありません" unless @post.user == current_user
  end

  def update
    if @post.user == current_user && @post.update(post_params)
      redirect_to posts_path, notice: "投稿を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @post.user == current_user
      @post.destroy
      redirect_to posts_path, notice: "投稿を削除しました"
    else
      redirect_to posts_path, alert: "権限がありません"
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content, :genre_id)
  end
end
