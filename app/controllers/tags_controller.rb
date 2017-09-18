class TagsController < ApplicationController
  before_action :authenticate_user!

  def index
    @title = "Index"
    @tags = current_user.cookbook.tags
  end

end
