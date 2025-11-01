class PostsController < ApplicationController
  # layout :select_layout
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_post, only: [ :show, :edit, :update, :destroy ]

  # みんなのアイデア一覧
  def index
    @posts = Post.includes(:user, :genre).order(created_at: :desc)
  end

  # コメント一覧兼詳細
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user).order(created_at: :desc)
    @comment = Comment.new

    set_meta_tags(
      title: "#{@post.user.display_name}のアイデア - #{@post.genre.name}",
      description: @post.content.truncate(60),
      og: {
        title: "#{@post.user.display_name}のアイデア - #{@post.genre.name}",
        description: @post.content.truncate(80),
        type: "article",
        url: post_url(@post),
        image: view_context.image_url("ogp.png")
      },
      twitter: {
        card: "summary_large_image",
        site: "@your_twitter_id", # 任意でOK
        image: view_context.image_url("ogp.png")
      }
    )
  end

  def new
    @post = current_user.posts.build
    @genres = Genre.all
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, notice: t("notices.created", resource: Post.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    redirect_back fallback_location: posts_path, alert: t("alerts.unauthorized") unless @post.user == current_user
    @genres = Genre.all
  end

  def update
    if @post.user == current_user && @post.update(post_params)
      redirect_path = params[:from].presence ? CGI.unescape(params[:from]) : posts_path
      redirect_to redirect_path, notice: t("notices.updated", resource: Post.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @post.user == current_user
      @post.destroy
      redirect_back fallback_location: posts_path, notice: t("notices.destroyed", resource: Post.model_name.human)
    else
      redirect_back fallback_location: posts_path, alert: t("alerts.unauthorized")
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
