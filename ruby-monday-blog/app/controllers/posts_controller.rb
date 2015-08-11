class PostsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create]

  def index
    @posts = Post.ordered_by_created_at.includes(:tags).page params[:page]
  end

  def new
    @post = Post.new
    @tag = @post.tags.build
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      flash[:notice] = "Post has been created."
      redirect_to @post
    else
      render 'new'
    end
  end

  def show
    @post = Post.find(params[:id])
    @tags = @post.tags
  end

  protected

  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to posts_path, notice: 'You need to log in to create a post.'
    end
  end

  private

  def post_params
    params.require(:post).permit(:body, :title, :image,
      :tags_attributes => [:id, :content])
  end
end
