class TagsController < ApplicationController

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
  end

  private
  def tag_params
    params.require(:tag).permit(:content)
  end
end
