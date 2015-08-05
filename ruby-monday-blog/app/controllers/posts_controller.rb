class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
    @tag = @post.tags.build
  end

  def create
    @post = Post.new(prepared_params)

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

  private
  def post_params
    params.require(:post).permit(:body, :title, :image,
      :tags_attributes => [:id, :content])
  end

  # prepared_params
  include Titleize
end
