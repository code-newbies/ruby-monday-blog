class TagsController < ApplicationController

  def new
  @tag = Tag.new
  end
end
