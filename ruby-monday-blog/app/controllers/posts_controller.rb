class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
    @tag = @post.tags.build
  end

  def create
    params = post_params

    # Extract the tag
    tag = params.extract!(:tags_attributes)
    tag_data = tag[:tags_attributes]["0"]
    prepared_tag = Tag.find_or_create_by(tag_data)

    @post = Post.new(params)
    prepared_tag.posts << @post

    if @post.persisted?
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
end
