class PostsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create]
  after_action :verify_authorized, except: :index

  def index
    @posts = Post.ordered_by_created_at.includes(:tags).page params[:page]
  end

  def show
    @post = Post.find(params[:id])
    @tags = @post.tags
    authorize @post
  end

  def new
    @post = Post.new
    authorize @post
    @tag = @post.tags.build
  end

  def edit
    @post = Post.find(params[:id])
    authorize @post
    fail NotImplementedError
  rescue NotImplementedError
    flash[:alert] = "We're still working on this feature!"
    redirect_to request.referrer || @post
  end

  def create
    @post = current_user.posts.new(post_params)
    authorize @post

    if @post.save
      flash[:notice] = "Post has been created."
      redirect_to @post
    else
      render 'new'
    end
  end

  def update
    fail NotImplementedError
  end

  def destroy
    @post = Post.find(params[:id])
    authorize @post
    if @post.destroy
      flash[:notice] = "Post has been deleted."
      redirect_to posts_path
    else
      flash[:alert] = "We couldn't process your request."
      redirect_to request.referrer || @post
    end
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
                                 tags_attributes: [:id, :content])
  end
end
