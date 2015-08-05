class TagsController < ApplicationController

  def index
    @tags = Tag.all
  end

  def new
  @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      flash[:notice] = "#{@tag.content} has been added."
    redirect_to @tag
    else
      render 'new'
    end
  end

  def show
    @tag = Tag.find(params[:id])
    @post = @tag.posts.order(created_at: :desc)
  end

  private
  def tag_params
    params.require(:tag).permit(:content)
  end
end
